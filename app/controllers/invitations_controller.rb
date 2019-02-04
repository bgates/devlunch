class InvitationsController < ApplicationController

  def create
    slack_request = Slack::Events::Request.new(request)
    begin
      slack_request.verify!
      render json: { response_type: "in_channel" }
    rescue
      render json: {
        response_type: "ephemeral",
        text: "Sorry, that didn't work. Please try again."
      }
    end
  end
end
