class RequestController < ApplicationController
  skip_before_action :verify_authenticity_token
  def request
    json_request = request.body.read
#    json_request ||= JSON.parse(request.body.read, {:symbolize_names => true})
    if !json_request.blank?
      personal = json_request
    else
      personal = {'status' => 500}
    end

    render :json => personal
  end
end
