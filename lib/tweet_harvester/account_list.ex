defmodule TweetHarvester.AccountList do
  use GenServer

  # -- Client

  def start_link(opts \\ []) do 
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def add_account(server, username, settings) do
    GenServer.cast(server, {:add_account, {username, settings ++ [ username: username ]}})
  end

  def set_processing_flag(server, username) do
    GenServer.cast(server, {:set_processing_flag, username})
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

  def handle_cast({:add_account, { username, settings}}, current_config) do
    {:noreply, HashDict.put(current_config, username, settings)}
  end

  def handle_cast({:set_processing_flag, username}, current_config) do
    {:noreply, HashDict.put(current_config, username, settings ++ [ is_processing: true ])}
  end

  def handle_cast({:save, { username, settings }}, current_config) do
    {:noreply, HashDict.put(current_config, username, settings)}
  end

  def handle_call({:find, name}, _from, names) do
    {:reply, HashDict.fetch(names, name), names}
  end

end