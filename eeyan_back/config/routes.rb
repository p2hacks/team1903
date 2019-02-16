Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "chat/index" => "chatget#index"

  post "chat/post" => "chatpost#room"
end
