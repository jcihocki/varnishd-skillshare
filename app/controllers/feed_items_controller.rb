class FeedItemsController < ApplicationController
  def show

    respond_to do |format|
      format.html {
        if params[:id][0] == "X"
          cache_me
          do_esi
        else
          @item = $redis.hgetall( params[:id] )
        end
      }
      format.esi {
        @item = $redis.hgetall( params[:id] )
        cache_me
        render "_fragment.html.erb", layout: false
      }
    end
  end
end