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
        text: "Sorry, that didn't work. Please try again. Locally I see this: #{Slack::Events.config.signing_secret},  on heroku I see this: #{slack_request.signature}"
      }
    end
  end
end
