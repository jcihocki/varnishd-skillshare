class FeedsController < ApplicationController
  def show
    do_esi
    @items = $redis.lrange( "feed", 0, 10 )
  end
end