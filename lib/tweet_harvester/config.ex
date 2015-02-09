defmodule TweetHarvester.Config do
  use GenServer

  # -- Client

  def start_link(username, api_key, api_secret) do 
    server = [
      username: username, 
      api_key: api_key, 
      api_secret: api_secret,
      polling_ms: 5000
    ]
    GenServer.start_link(__MODULE__, server)
  end

  def save(server, config) do
    GenServer.cast(server, {:save, config})
  end

  def find(server) do
    GenServer.call(server, :find)
  end


  # -- Server

  def handle_cast({:save, new_config}, _current_config) do
    {:noreply, new_config}
  end

  def handle_call(:find, _from, current_config) do
    { :reply, current_config, current_config }
  end

end