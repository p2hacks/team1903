Rails.application.routes.draw do
  get "posts/index" => "post#index"
  post "posts/index" => "post#request"
  post "posts/request" => "request#hello"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
