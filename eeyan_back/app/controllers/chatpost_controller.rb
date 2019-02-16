class ChatpostController < ApplicationController
  skip_before_action :verify_authenticity_token
  def room
    json_request = JSON.parse(request.body.read, {:symbolize_names => true})
    if !json_request.blank?
      post = Chat.new
      post.user_id = json_request[:user_id]
      post.room_id = json_request[:room_id]
      post.content = json_request[:content]
      post.save
      personal = json_request
    else
      personal = { status => 500 }
    end

    render :json => personal
  end
end
