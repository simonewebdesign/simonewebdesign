require 'bundler/setup'
require 'sinatra/base'

class SinatraStaticServer < Sinatra::Base
  # Redirect /blog to /
  get '/blog/?' do
    redirect '/', 301
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

    statement = db.prepare "INSERT IGNORE INTO users VALUES (?)"
    statement.execute(addr)

    halt 200
  end

  get '/unsub/?' do
    halt 400 unless params.has_key?('email')

    require 'cgi'
    addr = CGI.unescape params['email']
    halt 400 unless addr =~ URI::MailTo::EMAIL_REGEXP

    statement = db.prepare "DELETE FROM users WHERE email = ?"
    statement.execute(addr)

    send_sinatra_file(request.path)
  end

  # Redirect all requests without a trailing slash to the trailing slash version
  # Except for some file extensions
  # https://stackoverflow.com/a/11927449
  get %r{(/.*[^\/])} do
    if params[:captures].first =~ /\.(gif|jpg|jpeg|png|webp|ico|js|json)$/
      return send_sinatra_file(request.path) {404}
    end

    redirect "#{params[:captures].first}/", 301
  end

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_file(File.join(__dir__, 'public', '404/index.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(__dir__, 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    file_path = file_path.chomp('/') if file_path.end_with?('/')
    send_file(file_path) if File.exist?(file_path)
    missing_file_block.call
  end

  private

  def db
    require 'mysql2'
    Mysql2::Client.new(
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      host: ENV['DB_HOST'],
      port: ENV['DB_PORT'],
      database: ENV['DB_NAME'],
    )
  end
end

run SinatraStaticServer
