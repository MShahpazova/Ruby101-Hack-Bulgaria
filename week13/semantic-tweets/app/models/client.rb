class Client
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "AHf8JFl1PtvdS7TnEjmPZ6vx9"
      config.consumer_secret = "b6MnfmnbOv5pwwo1sjNH3CALmkhZiu4c6cIeLLECvfpOvfiX2U"
    end
  end
  
  def last_tweets(user_name:, count: 200)
    @client.user_timeline(user_name, count: count)
  end

  # [Twitter::Tweet]
  # Twitter::Tweet#text
end