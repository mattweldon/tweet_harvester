defmodule TweetHarvesterWorkerTest do
  use ExUnit.Case

  test "testing initial worker implementation" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_config(sup)

    TweetHarvesterConfig.add_account_for_harvest(
      config,
      "mattweldon", 
      System.get_env("TWITTER_CONSUMER_KEY"), 
      System.get_env("TWITTER_CONSUMER_SECRET"), 
      System.get_env("TWITTER_ACCESS_TOKEN"),
      System.get_env("TWITTER_ACCESS_SECRET")
    )

    worker_config = TweetHarvesterConfig.find(config, "mattweldon")
  end

end