# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

$redis = Redis.new host: $config.redis_url.host, port: $config.redis_url.port, password: $config.redis_url.password

require 'rest-client'

pics = ["sharpei.jpg", "retriever.jpg", "corgi.jpg", "boxer.jpg"]
time = 3.hours.ago.to_i

$redis.keys( "*" ).each {|k| $redis.del k }

10.times do |i|
  time -= (2..48).to_a.sample.hours.to_i
  id = "#{ ['X', ''].sample }#{i}"
  $redis.mapped_hmset( id,
    id: id,
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