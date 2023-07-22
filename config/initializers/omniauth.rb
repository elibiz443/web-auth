OmniAuth.config.logger = Rails.logger

google_key = Rails.application.credentials[:GOOGLE][:GOOGLE_KEY]
google_secret = Rails.application.credentials[:GOOGLE][:GOOGLE_SECRET]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, google_key, google_secret
end
