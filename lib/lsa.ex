defmodule Demo.Lsa do
  use GenServer

  def start_link(lsa_topic) do
    GenServer.start_link(__MODULE__, {lsa_topic, nil})
  end

  def init({lsa_topic, _}) do
    {:ok, {lsa_topic, nil}}
  end

  def lsa_loop(lsa_topic) do
    loop(lsa_topic, 0)
  end

  defp loop(lsa_topic, sent_count) when sent_count < 5 do
    Process.sleep(1000)
    lsa_readings = [0, 0, 0, 0, 0]
    Demo.Pubsub.publish(lsa_topic, lsa_readings)

    loop(lsa_topic, sent_count + 1)
  end

  defp loop(_, _) do
    :ok
  end
end
