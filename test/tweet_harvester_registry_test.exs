defmodule TweetHarvesterRegistryTest do
  use ExUnit.Case

  test "creating a new registry entry returns :ok" do
    TweetHarvester.start_link
    assert TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon") == :ok
  end

  test "registry entries can be found by name" do
    TweetHarvester.start_link
    TweetHarvesterRegistry.create(TweetHarvesterRegistry, "mattweldon")
    assert {:ok, config_pid} = TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, "mattweldon")
  end

  test "looking for a non-existent registry entry returns :error" do
    TweetHarvester.start_link
    assert :error = TweetHarvesterRegistry.lookup(TweetHarvesterRegistry, "mattweldon")
  end

end
