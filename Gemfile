# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read(File.join(__dir__, '.ruby-version')).strip

group :development do
  gem 'compass', '~> 1.0'
  gem 'jekyll', '~> 4.2'
  gem 'rake', '~> 13.0'
  gem 'sass-globbing', '~> 1.1'
end

group :plugins do
  gem 'jekyll-gist', '~> 1.5'
  gem 'jekyll-sitemap', '~> 1.4'
end

# only these will get bundled in production
gem 'mysql2'
gem 'puma'
gem 'sinatra'
