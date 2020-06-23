require 'bundler/setup'
require 'sinatra/base'

class SinatraStaticServer < Sinatra::Base
  # Redirect /blog to /
  get '/blog/?' do
    redirect '/'
  end

  # Redirect whatever matches rss to atom.xml
  get '/rss/?' do
    redirect '/atom.xml', 301
  end

  get '/simone-vittori/?' do
    redirect '/about/', 301
  end

  post '/sub' do
    addr = request.body.read
    halt 400 unless addr =~ URI::MailTo::EMAIL_REGEXP

    require 'redis'
    redis = Redis.new(url: "redis://:#{ENV['REDIS_PASSWORD']}@#{ENV['REDIS_HOST']}")
    redis.sadd "emails", addr
  end

  get '/unsub/?' do
    halt 400 unless params.has_key?('email')

    require 'CGI'
    addr = CGI.unescape params['email']
    halt 400 unless addr =~ URI::MailTo::EMAIL_REGEXP

    require 'redis'
    redis = Redis.new(url: "redis://:#{ENV['REDIS_PASSWORD']}@#{ENV['REDIS_HOST']}")
    redis.srem "emails", addr

    send_sinatra_file(request.path)
  end

  # Redirect all requests without a trailing slash to the trailing slash version
  # Except for some file extensions
  # https://stackoverflow.com/a/11927449
  get %r{(/.*[^\/])} do
    if params[:captures].first =~ /\.(gif|jpg|png|ico|js|json)$/
      return send_sinatra_file(request.path) {404}
    end

    redirect "#{params[:captures].first}/"
  end

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_file(File.join(__dir__, 'public', '404.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(__dir__, 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i

    if file_path.end_with?('/')
      if File.exist?(file_path)
        send_file(file_path)
      else
        if File.exist?(file_path.chomp('/'))
          redirect to("https://www.simonewebdesign.it#{file_path.chomp('/')}"), 301
        else
          missing_file_block.call
        end
      end
    else
      # request does not end with '/'
      if File.exist?(file_path)
        send_file(file_path)
      else
        if File.exist?(file_path << '/')
          redirect to("https://www.simonewebdesign.it#{file_path}/"), 301
        else
          missing_file_block.call
        end
      end
    end
  end

end

run SinatraStaticServer
