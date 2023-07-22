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


i) Addind RSpec:

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
