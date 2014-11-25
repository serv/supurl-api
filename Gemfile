source 'https://rubygems.org'


gem 'rails', '4.1.6'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development

# User authentication
gem 'bcrypt', '~> 3.1.7'

# View
gem 'haml-rails', '~> 0.5.3'
gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'autoprefixer-rails', '~> 3.0.0.20140821'

# API & CORS support
gem 'grape', '~> 0.8.0'
gem 'grape-entity', '~> 0.4.3'
gem 'rack-cors', '~> 0.2.9'

group :development, :test do
  gem 'pry', '~> 0.10.0'
end

group :development do
  gem "thin", "~> 1.6.2"
  gem "better_errors", "~> 1.1.0"
  gem 'faker', '~> 1.4.2'

  # Deployment
  gem 'capistrano', '~> 3.2.0'
end

group :test do
  gem 'rspec-rails', '~> 3.0.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'shoulda-matchers', '~> 2.6.1'
  gem 'capybara', '~> 2.4.1'
  gem 'json_spec', '~> 1.1.2'
  # gem 'rack-test', '~> 0.6.2'
end

group :production do
  # Rails server
  gem 'unicorn', '~> 4.8.3'
end
