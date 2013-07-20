# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rest-client'

pics = ["sharpei", "retriever", "corgi.jpg", "boxer.jpg"]
JSON.parse( RestClient.get( "https://baconipsum.com/api/?type=all-meat&paras=1" ) ).first
time = 3.hours.ago.to_i

10.times.do |i|
  time -= (2..48).to_a.sample.hours
  id = "#{ ['X', ''].sample }#{i}"
  $redis.mapped_hmset( id,
    profile_pic: pics.sample,
    text: JSON.parse( RestClient.get( "https://baconipsum.com/api/?type=all-meat&paras=1" ) ).first,
    created_at: time.to_i,
    user_name: "#{"popular_" if id[0] =="X"}user_#{i}"
  )
  if id[0] == "X"
    $redis.rpush( "feed", id )
  else
    $redis.rpush( "feed", $redis.hgetall( id ).to_json )
  end
end