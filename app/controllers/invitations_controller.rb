class InvitationsController < ApplicationController
before_action :cors_preflight_check, only: :index
after_action :cors_set_access_control_headers, only: :index

  def create
    Invitation.create_from_yelp_data(params[:text], params[:user_id])
    render json: { response_type: "in_channel" }
  end

  def index 
    @invitations = Invitation.all
    respond_to do |format|
      format.html 
      format.json { render invitations: @invitations }
    end
  end

  private 

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == "OPTIONS"
      cors_set_access_control_headers
      render :text => '', :content_type => 'text/plain'
    end
  end
end
