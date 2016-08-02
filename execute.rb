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

CSV.open("#{file_name}.csv", "w") do |f|
  File.readlines(file_location).each_with_index do |tweet, i|
    puts "Reading line #{i}"
    tweet_hash = JSON.parse(tweet)

    if tweet_hash[matcher] == condition
      puts 'Match found, printing line #{i}'
      f << [
            tweet_hash['text'],
            tweet_hash['id'],
            tweet_hash['is_quote_status'],
            tweet_hash['lang'],
            tweet_hash['created_at']
      ]
    end
  end
end
