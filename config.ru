require 'bundler/setup'
require 'sinatra/base'

# The project root directory
$root = ::File.dirname(__FILE__)

class SinatraStaticServer < Sinatra::Base
  # Redirect all requests without a trailing slash to the trailing slash version
  # http://stackoverflow.com/a/11927449
  get %r{(/.*[^\/])$} do
    redirect "#{params[:captures].first}/"
  end

  # Redirect /blog to /
  get %r{blog/?$} do
    redirect '/'
  end

  # Redirect whatever matches rss to atom.xml
  get %r{rss/?$} do
    redirect '/atom.xml'
  end

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_file(File.join(File.dirname(__FILE__), 'public', '404.html'), {:status => 404})
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i

    if file_path.end_with?('/')
      if File.exist?(file_path)
        send_file(file_path)
      else
        if File.exist?(file_path.chomp('/'))
          redirect to("http://www.simonewebdesign.it#{file_path.chomp('/')}"), 301
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
          redirect to("http://www.simonewebdesign.it#{file_path}/"), 301
        else
          missing_file_block.call
        end
      end
    end
  end

end

run SinatraStaticServer
