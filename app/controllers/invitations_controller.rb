class InvitationsController < ApplicationController

  def create
    Invitation.create_from_yelp_data(params[:text], params[:user_id])
    render json: { response_type: "in_channel" }
  end

  def index 
    @invitations = Invitation.all
  end
end
