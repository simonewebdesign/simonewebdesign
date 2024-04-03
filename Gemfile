# frozen_string_literal: true

source 'https://rubygems.org'
ruby ">= #{File.read(".ruby-version").strip}"

group :development do
  gem 'compass', github: 'simonewebdesign/compass'
  gem 'jekyll', '~> 4.3'
  gem 'rake', '~> 13.0'
  gem 'sass-globbing', '~> 1.1'
  gem 'puma'
  gem 'sinatra'
  gem 'csv' # ruby/3.3.0/gems/jekyll-4.3.3/lib/jekyll.rb:28: warning: csv was loaded from the standard library, but will no longer be part of the default gems since Ruby 3.4.0. Add csv to your Gemfile or gemspec. Also contact author of jekyll-4.3.3 to add csv into its gemspec.
  gem 'bigdecimal' # ruby/3.3.0/gems/liquid-4.0.4/lib/liquid/standardfilters.rb:2: warning: bigdecimal was loaded from the standard library, but will no longer be part of the default gems since Ruby 3.4.0. Add bigdecimal to your Gemfile or gemspec. Also contact author of liquid-4.0.4 to add bigdecimal into its gemspec.
  gem 'rackup' # ruby/3.3.0/bundler/rubygems_integration.rb:265:in `block in replace_bin_path': can't find executable rackup for gem rack (Gem::Exception)
end

group :plugins do
  gem 'jekyll-gist', '~> 1.5'
  gem 'jekyll-sitemap', '~> 1.4'
end

# only these will get bundled in production
# gem 'mysql2'
