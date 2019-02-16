class PostController < ApplicationController

#  skip_before_action :verify_authenticity_token

  def index
    @post = Post.all
    @post.to_json

    response = @post
    render :json => response
  end
end
