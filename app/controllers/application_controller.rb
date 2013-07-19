class ApplicationController < ActionController::Base
  protect_from_forgery

  def home
    render
  end

  def static
    response.headers['Cache-Control'] = "public"
    response.headers['Expires'] =  1.hour.from_now.httpdate
    render
  end
end
