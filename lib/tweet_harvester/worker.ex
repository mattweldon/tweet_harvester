defmodule TweetHarvesterWorker do
  use GenServer

  # -- Client

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def poll(server, config) do
    spawn(GenServer.cast(server, {:poll, config}))
  end

  # -- Server

  def handle_cast({:poll, config}, _state) do

    # Get tweets for the user
    ExTwitter.configure(:process, [
      consumer_key: config[:consumer_key],
      consumer_secret: config[:consumer_secret],
      access_token: config[:access_token],
      access_token_secret: config[:access_secret]
    ])

    ExTwitter.user_timeline([screen_name: config[:username], count: 20]) |>
     Enum.map(fn(tweet) -> tweet.text end) |>
     Enum.join("\n-----\n") |>
     IO.puts


    # Add them to the tweet store

  end

end
