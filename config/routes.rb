VarnishdSkillshare::Application.routes.draw do
  root to: "application#home"

  match "/static" => "application#static"
end
