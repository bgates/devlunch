class InvitationsController < ApplicationController

  def create
    render json: { response_type: "in_channel" }
  end
end
