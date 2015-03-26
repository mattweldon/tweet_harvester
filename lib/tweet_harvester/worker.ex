defmodule TweetHarvester.Worker do

  def start(account_list) do
    loop(account_list)
  end

  def loop(account_list) do


    :timer.sleep(10000)
    loop(account_list)
  end

  def pick_account(account_list) do

  end

  def get_tweets(account) do
    ExTwitter.configure(:process, [
      consumer_key: account[:consumer_key],
      consumer_secret: account[:consumer_secret],
      access_token: account[:access_token],
      access_token_secret: account[:access_secret]
    ])

    ExTwitter.user_timeline([screen_name: account[:username], count: 20]) |>
     Enum.map(fn(tweet) -> tweet.text end) |>
     Enum.join("\n-----\n") |>
     IO.puts
  end

end
