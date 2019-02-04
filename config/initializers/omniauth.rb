opts = { scope: 'user:email' }

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Devlunch::Application.credentials.github_client_id, Devlunch::Application.credentials.github_client_secret, opts
end
