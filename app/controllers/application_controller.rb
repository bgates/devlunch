class ApplicationController < ActionController::Base
  protect_from_forgery unless: :slack_request?

private

  def slack_request?
    slack_request = Slack::Events::Request.new(request)
    begin
      slack_request.verify!
    rescue
      return false
    end
  end
end
