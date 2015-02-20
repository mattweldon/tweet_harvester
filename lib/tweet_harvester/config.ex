defmodule TweetHarvesterConfig do
  use GenServer

  # -- Client

  def start_link do 
    GenServer.start_link(__MODULE__, [])
  end

  def add_account_for_harvest(username, consumer_key, consumer_secret, access_token, access_secret) do
    credentials = [ 
      username: username, 
      consumer_key: consumer_key, 
      consumer_secret: consumer_secret, 
      access_token: access_token, 
      access_secret: access_secret
    ]

    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, {server, _worker}} -> 
        GenServer.cast(server, {:add_account_for_harvest, credentials})
      :error ->
        :error
    end
  end

  def save(username, config) do
    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, {server, _worker}} -> 
        GenServer.cast(server, {:save, config})
      :error ->
        :error
    end
  end

  def find(username) do
    case TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, username) do
      {:ok, {server, _worker}} ->
        GenServer.call(server, :find)
      :error ->
        :error
    end
  end

  # -- Server

  def handle_cast({:add_account_for_harvest, credentials}, current_config) do
    {:noreply, current_config ++ credentials}
  end

  def handle_cast({:save, new_config}, _current_config) do
    {:noreply, new_config}
  end

  def handle_call(:find, _from, current_config) do
    { :reply, current_config, current_config }
  end

end