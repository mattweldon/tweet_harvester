defmodule TweetHarvesterWorkerTest do
  use ExUnit.Case

  test "testing initial worker implementation" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    TweetHarvester.AccountList.add_account_for_harvest(
      config,
      "mattweldon", 
      System.get_env("TWITTER_CONSUMER_KEY"), 
      System.get_env("TWITTER_CONSUMER_SECRET"), 
      System.get_env("TWITTER_ACCESS_TOKEN"),
      System.get_env("TWITTER_ACCESS_SECRET")
    )

    worker_config = TweetHarvester.AccountList.find(config, "mattweldon")
  end

end