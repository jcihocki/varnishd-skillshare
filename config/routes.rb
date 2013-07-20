VarnishdSkillshare::Application.routes.draw do
  root to: "application#home"
  match "/your_ip" => "application#your_ip"

  match "/static" => "application#static"

  namespace :private do
    resource :content
  end

  resource :feed do
    resources :feed_items, :path => "items"
  end
end
