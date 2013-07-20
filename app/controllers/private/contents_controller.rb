class Private::ContentsController < Private::ApplicationController
  def show
    cache_me
    render
  end


end