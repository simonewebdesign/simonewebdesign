# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra/base'

class SinatraStaticServer < Sinatra::Base
  # Redirect /blog to /
  get '/blog/?' do
    redirect '/', 301
  end

  # Redirects /posts, posts/, posts/n, posts/n/ to home page
  # This is for legacy reasons, because those pages are
  # still indexed by Google to date, and ideally the bot
  # should never see a 404.
  get '/posts/?:pagenum?/?' do
    redirect '/archives/', 301
  end

  # Redirect whatever matches rss to atom.xml
  get '/(rss|feed)/?' do
    redirect '/atom.xml', 301
  end

  get '/simone-vittori/?' do
    redirect '/about/', 301
  end

  post '/sub' do
    new_email = params['email']
    unless new_email =~ URI::MailTo::EMAIL_REGEXP
      Thread.new do
        send_mail_to_yourself("[swd] /sub 400 (invalid email=#{new_email})", "Ref: #{request.env['HTTP_REFERER']}")
      end
      halt 400
    end

    Thread.new do
      statement = db.prepare 'INSERT IGNORE INTO users (email, ref) VALUES (?, ?)'
      statement.execute(new_email, request.env['HTTP_REFERER'])

      send_mail_to_yourself("[swd] New sub (email=#{new_email})", "Ref: #{request.env['HTTP_REFERER']}")
    end

    send_sinatra_file(request.path)
  end

  get '/unsub/?' do
    redirect "/", 301 unless params.key?('email')

    email = params['email']
    unless email =~ URI::MailTo::EMAIL_REGEXP
      Thread.new do
        send_mail_to_yourself("[swd] /unsub 400 (invalid email=#{email})", "Ref: #{request.env['HTTP_REFERER']}")
      end
      halt 400
    end

    Thread.new do
      statement = db.prepare 'DELETE FROM users WHERE email = ?'
      statement.execute(email)

      # TODO: log referrer from unsub email as query param
      send_mail_to_yourself("[swd] Unsub (email=#{email})", "Ref: #{request.env['HTTP_REFERER']}")
    end

    send_sinatra_file(request.path)
  end

  # Redirect all requests without a trailing slash to the trailing slash version
  # Except for some file extensions
  # https://stackoverflow.com/a/11927449
  get %r{(/.*[^\/])} do
    if params[:captures].first =~ /\.(mp4|gif|jpg|jpeg|png|webp|ico|css|js|json|xml|asc|txt|otf|eot|svg|ttf|html|htm|php|cgi)$/
      return send_sinatra_file(request.path) { 404 }
    end

    redirect "#{params[:captures].first}/", 301
  end

  get(/.+/) do
    send_sinatra_file(request.path) { 404 }
  end

  not_found do
    send_file(File.join(__dir__, 'public', '404/index.html'), { status: 404 })
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(__dir__, 'public', path)
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
      database: ENV['DB_NAME']
    )
  end

  def send_mail_to_yourself(subject, body = '')
    msgstr = <<END_OF_MESSAGE
Subject: #{subject}

#{body}
END_OF_MESSAGE
    require 'net/smtp'
    smtp = Net::SMTP.new ENV['SIMO_SMTP_SERVER'], ENV['SIMO_SMTP_PORT']
    smtp.enable_starttls
    smtp.start('simonewebdesign.it', ENV['SIMO_AUTH_USERNAME'], ENV['SIMO_AUTH_PASSWORD'], :login) do |sm|
      from_addr = 'site@simonewebdesign.it'
      to_addr = 'hello@simonewebdesign.it'

      sm.send_message msgstr, from_addr, to_addr
    end
  end
end

run SinatraStaticServer
