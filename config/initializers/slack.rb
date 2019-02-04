Slack::Events.configure do |config|
  config.signing_secret = Devlunch::Application.credentials.slack_signing_secret
end
