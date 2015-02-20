defmodule TweetHarvesterWorkerTest do
  use ExUnit.Case

  test "testing initial worker implementation" do

    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")
    TweetHarvesterConfig.add_account_for_harvest(
      "mattweldon", 
      System.get_env("TWITTER_CONSUMER_KEY"), 
      System.get_env("TWITTER_CONSUMER_SECRET"), 
      System.get_env("TWITTER_ACCESS_TOKEN"),
      System.get_env("TWITTER_ACCESS_SECRET")
    )

    {:ok, {config, worker}} = TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, "mattweldon")

    worker_config = TweetHarvesterConfig.find("mattweldon")
  end

end