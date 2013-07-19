class Private::ApplicationController < ApplicationController

  before_filter :require_login

  private

  def require_login
    if params[:auth_token]
      if params[:auth_token] != "XXXXXX"
        # rejects requests with wrong token
        render text: "Auth secret invalid", status:  :forbidden
      end
      # otherwise, let page render and set caching headers
    else
      authenticate_or_request_with_http_basic do |username, password |
        if username == "username" && password == "password"
          if Rails.env.development? || request.env['HTTP_X_VARNISHD_SECRET'] == 'rPo7CkECQTW4Pu2UzdpbLk2Rs10mxGPf8W9CQ1k5z2nKXV/aTjls94vdHzlAWwxh'
            do_esi
            # Adds auth token XXXXXX to current url and esi includes it
            render text: "<esi:include xmlns:esi=\"http://www.edge-delivery.org/esi/1.0\" src=\"#{url_for( auth_token: "XXXXXX" )}\" onerror=\"continue\" />", content_type: "text/html"
          else
            render text: "Oh no you didn't!", status:  :forbidden
          end
        else
          head :unauthorized
        end
      end
    end
  end
end