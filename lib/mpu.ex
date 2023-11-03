defmodule Demo.Mpu do
  use GenServer

  def start_link(mpu_topic) do
    GenServer.start_link(__MODULE__, {mpu_topic, nil})
  end

  def init(mpu_topic) do
    {:ok, {mpu_topic, nil}}
  end

  def mpu_loop(mpu_topic) do
    loop(mpu_topic, 0)
  end

  defp loop(mpu_topic, sent_count) when sent_count < 5 do
    Process.sleep(1000)
    mpu_readings = 1000
    Demo.Pubsub.publish(mpu_topic, mpu_readings)

    loop(mpu_topic, sent_count + 1)
  end

  defp loop(_, _) do
    :ok
  end
end
