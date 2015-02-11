defmodule TweetHarvesterWorkerTest do
  use ExUnit.Case

  test "testing initial worker implementation" do

    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")
    TweetHarvesterConfig.set_api_credentials(
      "mattweldon", 
      System.get_env("TWITTER_CONSUMER_KEY"), 
      System.get_env("TWITTER_CONSUMER_SECRET"), 
      System.get_env("TWITTER_ACCESS_TOKEN"),
      System.get_env("TWITTER_ACCESS_SECRET")
    )

    {:ok, {config, worker}} = TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, "mattweldon")

    worker_config = TweetHarvesterConfig.find("mattweldon")

    IO.inspect worker
    # IO.inspect worker_config

    # TweetHarvesterWorker.poll(worker, worker_config)

  end

end