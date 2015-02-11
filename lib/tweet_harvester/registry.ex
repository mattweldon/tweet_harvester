defmodule TweetHarvesterRegistry do
  use GenServer

  # -- Client

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def create(server, name) do
    GenServer.cast(server, { :create, name })
  end

  def lookup(server, name) do
    GenServer.call(server, { :lookup, name })
  end

  def crash(server) do
    GenServer.cast(server, :crash)
  end

  # -- Server

  def init(_) do
    { :ok, HashDict.new }
  end

  def handle_call({:lookup, name}, _from, names) do
    {:reply, HashDict.fetch(names, name), names}
  end

  def handle_cast(:crash, _state) do
    1 = 2
  end

  def handle_cast({:create, name}, names) do
    if HashDict.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, config} = TweetHarvesterConfig.start_link()
      {:ok, worker} = TweetHarvesterWorker.start_link()

      {:noreply, HashDict.put(names, name, {config, worker})}
    end
  end

end