Rails.application.routes.draw do
  get "posts/index" => "post#index"
  post "posts/index" => "post#request"
  post "posts/request" => "request#hello"
  
  get "chats/index" => "chatget#index"
  get "chats/:room_id/get" => "chatget#room_id"

  post "chats/post" => "chatpost#room"
  post "chats/:id1/:id2/post" => "chatpost#room1"
  post "chats/:id2/:id3/post" => "chatpost#room2"
  post "chats/:id3/:id1/post" => "chatpost#room3"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
