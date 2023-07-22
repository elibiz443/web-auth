# WEB-AUTH

1. Create a new web application:

I start by runing in terminal:
```
rails new web-auth -j esbuild -c tailwind -d postgresql -T && cd web-auth && subl .
```
I do this so as to generate rails 7 API skeleton.

Requirements:
* postgresql as the database for Active Record.
* Ruby version 3.2.0
* Rails version 7.0.4
* Doesn't use the default Minitest for testing coz I will be using RSpec.


Addind RSpec:

In Gemfile, add:
```
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails", :require => false
  gem "faker"
  gem "database_cleaner-active_record"
end
```
In Terminal, Run:
```
bundle && rails g rspec:install && mkdir spec/support && touch spec/support/factory_bot.rb && touch spec/factories.rb
```

Configuration:
```
# spec/support/factory_bot.rb

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions
end

# spec/rails_helper.rb

require_relative 'support/factory_bot'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# spec/factories.rb

FactoryBot.define do
end
```

Run Tests with:
```
rspec
```

2. Add omniauth gem
```
gem 'omniauth'
gem "omniauth-rails_csrf_protection"
gem 'omniauth-google-oauth2'
```
----> Create Google projects and fetch their API keys and secrets here.
Starting point to a new google project:
```
 https://console.cloud.google.com
 ```
 * Create Project
 * Go to APIs & Services > Oauth consent screen and choose External.
 * Next is go to APIs & Services > Credentials. At the top click CREATE CREDENTIALS and choose OAuth client ID.
 * Choose Web application as Application type.
 * Then add the callback URL to Authorized redirect URIs.
 * Then click Create. After creation, there should be a popup showing your client id and client secret. Save it for later use.

3. Add config/initializers/omniauth.rb file and update it as follows:
```
OmniAuth.config.logger = Rails.logger

google_key = Rails.application.credentials[:GOOGLE][:GOOGLE_KEY]
google_secret = Rails.application.credentials[:GOOGLE][:GOOGLE_SECRET]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, google_key, google_secret
end
```
Use: (To edit Credentials)
```
EDITOR="subl --wait" rails credentials:edit
```
credentials file should be in the following format:
```
GOOGLE:
  GOOGLE_KEY: your_google_key
  GOOGLE_SECRET: your_google_secret
```

For Google:
```
https://console.cloud.google.com
```
* Create Project
* Go to APIs & Services > Oauth consent screen and choose External.
* Next is go to APIs & Services > Credentials. At the top click CREATE CREDENTIALS and choose OAuth client ID.
* Choose Web application as Application type.
* Then add the callback URL to Authorized redirect URIs.
* Then click Create. After creation, there should be a popup showing your client id and client secret. Save it for later use.

Add to whitelist:
```
Go to: https://console.cloud.google.com/apis/credentials/consent

Input: 
http://localhost:3000/auth/google_oauth2/callback
```
