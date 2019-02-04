class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :slack_request?

private

  def slack_request?
    slack_request = Slack::Events::Request.new(request)
    begin
      slack_request.verify!
    rescue

        digest = OpenSSL::Digest::SHA256.new
        signature_basestring = [slack_request.version, slack_request.timestamp, slack_request.body].join(':')
        #hex_hash = OpenSSL::HMAC.hexdigest(digest, Slack::Events.config.signing_secret, signature_basestring)
        #computed_signature = [slack_request.version, hex_hash].join('=')
      render json: {
        response_type: "ephemeral",
        text: "Sorry, that didn't work. Please try again. signature_basestring:#{signature_basestring}, #{Slack::Events.config.signing_secret},  #{slack_request.signature}"
      }
    end
  end
end
