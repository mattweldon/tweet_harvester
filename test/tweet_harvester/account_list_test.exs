defmodule TweetHarvester.AccountListTest do
  use ExUnit.Case

  test "add_account_for_harvest adds credentials for the keyname given" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    settings = [
      consumer_key: "consumer", 
      consumer_secret: "consumer secret", 
      access_token: "access",
      access_secret: "access secret"
    ]

    TweetHarvester.AccountList.add_account(config, "mattweldon", settings)

    { :ok, updated_config } = TweetHarvester.AccountList.find(config, "mattweldon")

    assert updated_config[:username] == "mattweldon"
    assert updated_config[:consumer_key] == "consumer"
    assert updated_config[:consumer_secret] == "consumer secret"
    assert updated_config[:access_token] == "access"
    assert updated_config[:access_secret] == "access secret"
  end

  test "saving config returns :ok" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    assert :ok = TweetHarvester.AccountList.save(config, "mattweldon", [test_key: "test value"])
  end

  test "config is saved to the named registry entry" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    TweetHarvester.AccountList.save(config, "mattweldon", [test_key: "test value"])
    TweetHarvester.AccountList.save(config, "johndoe", [test_key2: "test value2"])

    { :ok, updated_config } = TweetHarvester.AccountList.find(config, "mattweldon")

    assert updated_config == [test_key: "test value"]
  end

  test "finding config for an unknown keyname returns :error" do
    { :ok, sup } = TweetHarvester.start_link
    { :ok, config } = TweetHarvester.start_account_list(sup)

    assert :error = TweetHarvester.AccountList.find(config, "johndoe")
  end

end
