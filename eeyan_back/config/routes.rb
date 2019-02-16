Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "chat/index" => "chatget#index"
  get "chat/:room_id/get" => "chatget#room_id"

  post "chats/post" => "chatpost#room"
  post "chats/:user_id/:room_id/post" => "chatpost#room_id"
end
