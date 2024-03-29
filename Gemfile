# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'amazing_print'
gem 'apartment', github: 'influitive/apartment', branch: 'development' # https://github.com/influitive/apartment/issues/617
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise', '~> 4.7'
gem 'jbuilder', '~> 2.7'
gem 'money-rails', '~> 1.13'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'pundit', '~> 2.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'simple_form', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop', '~> 0.91.0', require: false
  gem 'rubocop-performance', '~> 1.5.2', require: false
  gem 'shoulda-matchers', '~> 4.4.1'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubycritic', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'pundit-matchers', '~> 1.6'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.19.0', require: false
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
