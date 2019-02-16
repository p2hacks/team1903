class ChatgetController < ApplicationController
  def index
    post = Chat.all
    post.to_json

    response = post
    render :json => response
  end

  def room_id
    post = Chat.where(room_id: params[:room_id])
    post.to_json

    response = post
    render :json => response
  end
end
