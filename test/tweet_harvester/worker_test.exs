defmodule TweetHarvesterWorkerTest do
  use ExUnit.Case

  test "testing initial worker implementation" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    settings = [
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"), 
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"), 
      access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
      access_secret: System.get_env("TWITTER_ACCESS_SECRET")
    ]

    TweetHarvester.AccountList.add_account(
      config,
      "mattweldon",
      settings
    )

    worker_config = TweetHarvester.AccountList.find(config, "mattweldon")
  end

end