defmodule Demo.Pubsub do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:publish, _topic_pid, message}, state) do
    # IO.inspect(topic_pid)
    # IO.inspect(state)

    Enum.each(state, fn sub_pid ->
      callback(sub_pid, message)
    end)

    {:noreply, state}
  end

  def handle_cast({:subscribe, sub_pid}, state) do
    {:noreply, Map.put(state, sub_pid, :subscriber)}
  end

  def publish(topic_pid, message) do
    # IO.inspect(topic_pid)
    # IO.inspect(message)
    GenServer.cast(topic_pid, {:publish, self(), message})
  end

  def subscribe(topic_pid, sub_pid) do
    # IO.inspect(topic_pid)
    # IO.inspect(sub_pid)
    GenServer.cast(topic_pid, {:subscribe, sub_pid})
  end

  defp callback(sub_pid, message) do
    {pid,_}=sub_pid
    # IO.inspect(pid)
    # IO.inspect(message)
    GenServer.cast(pid, {:callback, message})
  end
end
