defmodule Demo.Motors do
  use GenServer

  def start_link(output_topic) do
    GenServer.start_link(__MODULE__, output_topic)
  end

  def init(output_topic) do
    Demo.Pubsub.subscribe(output_topic, self())

    {:ok, output_topic}
  end

  def handle_cast({:callback, message}, output_topic) do
    # IO.inspect(message)
    output_callback(message)
    {:noreply,output_topic}
  end

  def output_callback(message) do
    IO.inspect(message, label: "Received message in Motors  ")
  end
end
