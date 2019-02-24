Slack.configure do |config|
  config.token = Devlunch::Application.credentials.slack_api_token
end

Slack::Events.configure do |config|
  config.signing_secret = Devlunch::Application.credentials.slack_signing_secret
end