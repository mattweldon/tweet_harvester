defmodule TweetHarvester do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @registry_name TweetHarvesterRegistry

  # def start_workers(sup) do
  #   # -- Config
  #   result = {:ok, config_pid} = Supervisor.start_child(sup, worker(TweetHarvesterRegistry, []))
  #   result
  # end

  # def init(_) do
  #   children = [ worker(TweetHarvesterRegistry, []) ]
  #   supervise([], strategy: :one_for_one)
  # end  

  def init(:ok) do
    children = [
      worker(TweetHarvesterRegistry, [[name: @registry_name]])
    ]
    IO.inspect children
    supervise(children, strategy: :one_for_one)
  end
end
