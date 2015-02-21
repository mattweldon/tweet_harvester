defmodule TweetHarvester do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def start_config(sup) do
    Supervisor.start_child(sup, [])
  end

  @registry_name TweetHarvesterRegistry

  def init(:ok) do
    children = [
      worker(TweetHarvesterConfig, []),
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end
