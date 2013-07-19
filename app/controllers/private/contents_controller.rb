class Private::ContentsController < Private::ApplicationController
  before_filter

  def show
    cache_me
    render
  end
end