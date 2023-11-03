
defmodule Demo.Mcu do
  use GenServer

  def start_link(lsa_topic, mpu_topic, output_topic) do
    GenServer.start_link(__MODULE__, {lsa_topic, mpu_topic, output_topic})
  end

  def init({lsa_topic, mpu_topic, output_topic}) do
    Demo.Pubsub.subscribe(lsa_topic, self())
    Demo.Pubsub.subscribe(mpu_topic, self())

    {:ok, {lsa_topic, mpu_topic, output_topic}}
  end

  def handle_cast({:callback, message}, {lsa_topic, mpu_topic, output_topic}) do
    case message do
      [0, 0, 0, 0, 0] ->
        lsa_callback(message,output_topic)
      1000 ->
        mpu_callback(message,output_topic)
    end
    {:noreply, {lsa_topic, mpu_topic, output_topic}}
  end

  def lsa_callback(message,output_topic) do
    IO.inspect(message, label: "Received LSA message in MCU ")
    Demo.Pubsub.publish(output_topic, message)
  end

  def mpu_callback(message,output_topic) do
    IO.inspect(message, label: "Received MPU message in MCU ")
    Demo.Pubsub.publish(output_topic, message)
  end
end
