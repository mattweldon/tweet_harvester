defmodule TweetHarvester.AccountList do
  use GenServer

  # -- Client

  def start_link(opts \\ []) do 
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def add_account_for_harvest(server, username, consumer_key, consumer_secret, access_token, access_secret) do
    credentials = [ 
      username: username, 
      consumer_key: consumer_key, 
      consumer_secret: consumer_secret, 
      access_token: access_token, 
      access_secret: access_secret
    ]

    GenServer.cast(server, {:add_account_for_harvest, {username, credentials}})
  end

  def save(server, username, config) do
    GenServer.cast(server, {:save, { username, config }})
  end

  def find(server, username) do
    GenServer.call(server, {:find, username})
  end

  # -- Server

  def init(_) do
    { :ok, HashDict.new }
  end

  def handle_cast({:add_account_for_harvest, { username, settings}}, current_config) do
    {:noreply, HashDict.put(current_config, username, settings)}
  end

  def handle_cast({:save, { username, settings }}, current_config) do
    {:noreply, HashDict.put(current_config, username, settings)}
  end

  def handle_call({:find, name}, _from, names) do
    {:reply, HashDict.fetch(names, name), names}
  end

end