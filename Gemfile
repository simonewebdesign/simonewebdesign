# frozen_string_literal: true

source 'https://rubygems.org'
ruby ">= #{File.read(".ruby-version").strip}"

group :development do
  gem 'compass', github: 'simonewebdesign/compass'
  gem 'jekyll', '~> 4.2'
  gem 'rake', '~> 13.0'
  gem 'sass-globbing', '~> 1.1'
  gem 'puma'
  gem 'sinatra'
end

group :plugins do
  gem 'jekyll-gist', '~> 1.5'
  gem 'jekyll-sitemap', '~> 1.4'
end

# only these will get bundled in production
# gem 'mysql2'
