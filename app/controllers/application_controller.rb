class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :slack_request?

private

  def slack_request?
    slack_request = Slack::Events::Request.new(request)
    begin
      slack_request.verify!
    rescue
      render json: {
        response_type: "ephemeral",
        text: "Sorry, that didn't work. Please try again. #{Slack::Events.config.signing_secret},  #{slack_request.signature}, #{slack_request.timestamp}, #{slack_request.body}"
      }
    end
  end
end
