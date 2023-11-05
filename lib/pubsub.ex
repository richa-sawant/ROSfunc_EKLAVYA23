defmodule Demo.Pubsub do
  @moduledoc """
  This module provides a simple publish/subscribe (pubsub) implementation.
  It can be used to communicate between different processes in an Elixir application..
  """
  use GenServer

  @spec start_link() :: :ignore | {:error, any()} | {:ok, pid()}
  @doc """
  To start the pubsub server, call the start_link/0 function:
  Example:

  iex>{:ok, pubsub_pid} = Demo.Pubsub.start_link()

  """
  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  @spec init(any()) :: {:ok, any()}

  def init(state) do
    {:ok, state}
  end

  @spec publish(atom() | pid() | {atom(), any()} | {:via, atom(), any()}, any()) :: :ok
  @doc """
  To publish a message to a topic, call the publish/2 function,
  passing in the PID of the topic and the message to be published:
  Example:

  iex>Demo.Pubsub.publish(topic_pid, message)
  """

  def publish(topic_pid, message) do
    GenServer.cast(topic_pid, {:publish, self(), message})
  end

  @spec subscribe(atom() | pid() | {atom(), any()} | {:via, atom(), any()}, any()) :: :ok
  @doc """
  To subscribe to a topic, call the subscribe/2 function,
  passing in the PID of the topic and a callback function to be called when a message is published to the topic:
  Example:

  iex>Demo.Pubsub.subscribe(topic_pid, callback_fn)

  """
  def subscribe(topic_pid, callback_fn) do
    GenServer.cast(topic_pid, {:subscribe, self(), callback_fn})
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
end
