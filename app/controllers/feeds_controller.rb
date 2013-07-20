class FeedsController < ApplicationController
  def show
    do_esi
    @items = $redis.lrange( 0, 10 )
  end
end