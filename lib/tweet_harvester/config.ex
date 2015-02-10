defmodule TweetHarvesterConfig do
  use GenServer

  # -- Client

  def start_link do 
    GenServer.start_link(__MODULE__, [])
  end

  def set_api_credentials(username, consumer_key, consumer_secret, access_token, access_secret) do
    credentials = [ 
      username: username, 
      consumer_key: consumer_key, 
      consumer_secret: consumer_secret, 
      access_token: access_token, 
      access_secret: access_secret, 
      polling_ms: 30000 
    ]

    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, server} -> 
        GenServer.cast(server, {:set_api_credentials, credentials})
      :error ->
        :error
    end
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

  def handle_cast({:set_api_credentials, credentials}, current_config) do
    {:noreply, current_config ++ credentials}
  end

  def handle_cast({:save, new_config}, _current_config) do
    {:noreply, new_config}
  end

  def handle_call(:find, _from, current_config) do
    { :reply, current_config, current_config }
  end

end