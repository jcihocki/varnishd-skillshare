class FeedItemsController < ApplicationController
  def show
    do_esi
    cache_me
    @item = $redis.hgetall( params[:id] )
    raise ActionController::RoutingError.new( "Not found" ) unless @item
  end
end