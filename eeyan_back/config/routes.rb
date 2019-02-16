Rails.application.routes.draw do
  get "posts/index" => "post#index"
  post "posts/index" => "post#request"
  post "posts/request" => "request#hello"
  
  get "chats/index" => "chatget#index"
  get "chats/:id1/:id2/get" => "chatget#room1"
  get "chats/:id2/:id3/get" => "chatget#room2"
  get "chats/:id3/:id1/get" => "chatget#room3"

  post "chats/post" => "chatpost#room"
  post "chats/:id1/:id2/post" => "chatpost#room1"
  post "chats/:id2/:id3/post" => "chatpost#room2"
  post "chats/:id3/:id1/post" => "chatpost#room3"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
