class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :cache_me, except: :your_ip

  def home
    response.headers['X-Varnish-Do-Esi'] = "true"
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
end
