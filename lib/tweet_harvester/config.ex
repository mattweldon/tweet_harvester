defmodule TweetHarvesterConfig do
  use GenServer

  # -- Client

  def start_link(opts \\ []) do 
    GenServer.start_link(__MODULE__, [])
  end

  def add_account_for_harvest(server, username, consumer_key, consumer_secret, access_token, access_secret) do
    credentials = [ 
      username: username, 
      consumer_key: consumer_key, 
      consumer_secret: consumer_secret, 
      access_token: access_token, 
      access_secret: access_secret
    ]

    GenServer.cast(server, {:add_account_for_harvest, credentials})
  end

  def save(server, username, config) do
    GenServer.cast(server, {:save, config})
  end

  def find(server, username) do
    GenServer.call(server, :find)
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