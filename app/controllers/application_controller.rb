class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :cache_me, only: [:home, :static]
  before_filter :do_esi, only: :home

  def home
    render
  end

  def your_ip
    render "_your_ip.html.erb", layout: false
  end

  def static
    render
  end

  private

  def cache_me
    response.headers['Cache-Control'] = "public"
    response.headers['Expires'] =  1.hour.from_now.httpdate
  end

  def do_esi
    response.headers['X-Esi-Processing'] = "on"
    # We do this so that varnish doesn't have to unzip
    # the content before ESI processing.
    request.env.delete( 'HTTP_X_ACCEPT_ENCODING' )
  end
end
