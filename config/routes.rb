VarnishdSkillshare::Application.routes.draw do
  root to: "application#home"
  match "/your_ip" => "application#your_ip"

  match "/static" => "application#static"
end
