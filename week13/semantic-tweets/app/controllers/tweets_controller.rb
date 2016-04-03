class TweetsController < ApplicationController
  def index
    @tweets = Client.new.last_tweets(user_name: "sferik")
  end
end
