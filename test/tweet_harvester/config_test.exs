defmodule TweetHarvesterConfigTest do
  use ExUnit.Case

  test "add_account_for_harvest adds credentials for the keyname given" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")

    TweetHarvesterConfig.add_account_for_harvest("mattweldon", "consumer", "consumer secret", "access", "access secret")

    updated_config = TweetHarvesterConfig.find("mattweldon")

    assert updated_config[:username] == "mattweldon"
    assert updated_config[:consumer_key] == "consumer"
    assert updated_config[:consumer_secret] == "consumer secret"
    assert updated_config[:access_token] == "access"
    assert updated_config[:access_secret] == "access secret"
  end

  test "saving config returns :ok" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")

    assert :ok = TweetHarvesterConfig.save("mattweldon", [test_key: "test value"])
  end

  test "config is saved to the named registry entry" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "johndoe")

    TweetHarvesterConfig.save("mattweldon", [test_key: "test value"])
    TweetHarvesterConfig.save("johndoe", [test_key2: "test value2"])

    config = TweetHarvesterConfig.find("mattweldon")

    assert config == [test_key: "test value"]
  end

  test "saving config for an unknown keyname returns :error" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")

    assert :error = TweetHarvesterConfig.save("johndoe", [test_key2: "test value2"])
  end

  test "finding config for an unknown keyname returns :error" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")

    assert :error = TweetHarvesterConfig.find("johndoe")
  end

end
