defmodule Demo.Pubsub do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:publish, topic_pid, message}, state) do
    Enum.each(state, fn {_subscriber_pid, callback_fn} ->
      callback_fn.({topic_pid, message})
    end)

    {:noreply, state}
  end

  def handle_cast({:subscribe, sub_pid, callback_fn}, state) do
    {:noreply, Map.put(state, sub_pid, callback_fn)}
  end

  def publish(topic_pid, message) do
    GenServer.cast(topic_pid, {:publish, self(), message})
  end

  def subscribe(topic_pid, callback_fn) do
    GenServer.cast(topic_pid, {:subscribe, self(), callback_fn})
  end
end
