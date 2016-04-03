class TweetHelper
  def negative?(tweet)
    tweet.include?('no')
  end
 
  def positive?(tweet)
    tweet.include?('yes')
  end
end