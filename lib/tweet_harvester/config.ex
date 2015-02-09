defmodule TweetHarvesterConfig do
  use GenServer


  # -- Client

  def start_link do 
    GenServer.start_link(__MODULE__, [])
  end

  def save(server, config) do
    GenServer.cast(server, {:save, config})
  end

  def find(server) do
    GenServer.call(server, :find)
  end


  # -- Server

  def handle_cast({:save, new_config}, current_config) do
    {:noreply, new_config}
  end

  def handle_call(:find, _from, current_config) do
    { :reply, current_config, current_config }
  end

end