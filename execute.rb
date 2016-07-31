require 'json'
require 'csv'

file_location = ARGV[0]
if file_location.nil?
  puts 'You have to run this with a file as an argument'
  puts 'ex: ruby execute.rb file_name.json'
  raise IOError, 'You forgot a file! Damnit Sterling.'
end


file = file_location.split('.')
file_ext = file[-1]
unless file_ext == 'json'
  puts 'the file you run this script with must be a .json file'
  raise IOError, 'You need to use a JSON file! Come on Sterling.'
end

file_name = file[-2]
condition = 'en'
matcher = 'lang'
tweets = []

File.readlines(file_location).each_with_index do |tweet, i|
  puts "Reading line #{i}"

  tweet_hash = JSON.parse(tweet)
  tweets << {
      text: tweet_hash['text'],
      id: tweet_hash['id'],
      is_quote_status: tweet_hash['is_quote_status'],
      lang: tweet_hash['lang'],
      created_at: tweet_hash['created_at']
  } if tweet_hash[matcher] == condition
end

CSV.open("#{file_name}.csv", "w") do |f|
  count = tweets.count

  tweets.each_with_index{ |tweet, i|
    puts "printing line #{i} of #{count}"
    f << tweet.values
  }
end
