defmodule TweetHarvesterConfig do
  use GenServer


  # -- Client

  def start_link do 
    GenServer.start_link(__MODULE__, [])
  end

  def save(username, config) do
    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, server} -> 
        GenServer.cast(server, {:save, config})
      :error ->
        :error
    end
  end

  def find(username) do
    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, server} ->
        GenServer.call(server, :find)
      :error ->
        :error
    end
  end


  # -- Server

  def handle_cast({:save, new_config}, _current_config) do
    {:noreply, new_config}
  end

  def handle_call(:find, _from, current_config) do
    { :reply, current_config, current_config }
  end

end