class ChatgetController < ApplicationController
  def index
    post = Chat.all
    post.to_json

    response = post
    render :json => response
  end
end
