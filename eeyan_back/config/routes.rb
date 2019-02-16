Rails.application.routes.draw do
  get "posts/index" => "post#index"
  post "posts/index" => "post#request"
  post "posts/request" => "request#hello"
  
  get "chats/index" => "chatget#index"
  get "chats/:room_id/get" => "chatget#room_id"

  post "chats/post" => "chatpost#room"
  post "chats/:user_id/:room_id/post" => "chatpost#room_id"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
