defmodule Demo.Motors do
  use GenServer

  def start_link(output_topic) do
    GenServer.start_link(__MODULE__, output_topic)
  end

  def init(output_topic) do
    Demo.Pubsub.subscribe(output_topic, &output_callback/1)

    {:ok, output_topic}
  end

  defp output_callback({_, message}) do
    IO.inspect(message, label: "Received message in Motors")
  end
end
