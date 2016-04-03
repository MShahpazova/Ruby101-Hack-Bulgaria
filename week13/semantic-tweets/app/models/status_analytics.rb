class StatusAnalytics 
  def self.analize(tweet)
  file = File.read(File.join(Rails.root, 'app','assets', 'javascripts','words.json'))
  parsed_json = JSON.parse(file)

  end
end