class ApplicationController < ActionController::Base
  protect_from_forgery

  def home
    render
  end

  def static
    render
  end
end
