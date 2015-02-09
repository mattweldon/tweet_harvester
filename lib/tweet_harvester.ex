defmodule TweetHarvester do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @registry_name TweetHarvesterRegistry

  def init(:ok) do
    children = [
      worker(TweetHarvesterRegistry, [[name: @registry_name]])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
