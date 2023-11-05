defmodule Demo.Mcu do
  use GenServer

  def start_link(lsa_topic, mpu_topic, output_topic) do
    GenServer.start_link(__MODULE__, {lsa_topic, mpu_topic, output_topic})
  end

  def init({lsa_topic, mpu_topic, output_topic}) do
    Demo.Pubsub.subscribe(lsa_topic, fn message -> lsa_callback({lsa_topic, mpu_topic, output_topic}, message) end)
    Demo.Pubsub.subscribe(mpu_topic, fn message -> mpu_callback({lsa_topic, mpu_topic, output_topic}, message) end)
    {:ok, {lsa_topic, mpu_topic, output_topic}}
  end

  def lsa_callback({_, _, output_topic}, message) do
    # IO.inspect(message)
    {_pid,mess} = message
    IO.inspect(mess, label: "Received LSA message in MCU")
    Demo.Pubsub.publish(output_topic, mess)
  end

  def mpu_callback({_, _, output_topic}, message) do
    {_pid,mess} = message
    IO.inspect(mess, label: "Received MPU message in MCU")
    Demo.Pubsub.publish(output_topic, mess)
  end
end
