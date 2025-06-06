# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

## -- Rsync Deploy config -- ##
# Be sure your public key is listed in your server's ~/.ssh/authorized_keys file
ssh_user       = 'user@domain.com'
ssh_port       = '22'
document_root  = '~/website.com/'
rsync_delete   = false
rsync_args     = ''  # Any extra arguments to pass to rsync
deploy_default = 'rsync'

# This will be configured for you when you run config_deploy
deploy_branch  = 'gh-pages'

## -- Misc Configs -- ##

public_dir      = 'public'    # compiled site directory
source_dir      = 'source'    # source file directory
blog_index_dir  = 'source'    # directory for your blog's index page (if you put your index in source/blog/index.html, set this to 'source/blog')
deploy_dir      = '_deploy'   # deploy directory (for Github pages deployment)
stash_dir       = '_stash'    # directory to stash posts for speedy generation
posts_dir       = '_posts'    # directory for blog files
themes_dir      = '.themes'   # directory for blog files
new_post_ext    = 'md'  # default new post file extension when using the new_post task
new_page_ext    = 'md'  # default new page file extension when using the new_page task
server_host     = '0.0.0.0'   # default would be localhost, but 0.0.0.0 to test on mobile device
server_port     = '4000'      # port for preview server eg. localhost:4000

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  puts '## Set the codepage to 65001 for Windows machines'
  `chcp 65001`
end

minify_cmd = "node_modules/.bin/html-minifier \
--case-sensitive \
--collapse-boolean-attributes \
--collapse-whitespace \
--decode-entities \
--file-ext html \
--minify-css true \
--minify-js true \
--process-scripts application/ld+json \
--remove-attribute-quotes \
--remove-comments \
--remove-empty-attributes \
--remove-empty-elements \
--remove-optional-tags \
--remove-redundant-attributes \
--remove-script-type-attributes \
--remove-style-link-type-attributes \
--remove-tag-whitespace \
--sort-attributes \
--sort-class-name \
--trim-custom-fragments \
--input-dir public \
--output-dir public
"

#######################
# Working with Jekyll #
#######################

desc 'Generate jekyll site'
task :generate do
  puts '---> Generating Site with Jekyll...'
  # system "compass compile --css-dir #{source_dir}/stylesheets"
  system "node_modules/.bin/sass scss/:source/stylesheets/"
  system 'jekyll build --trace'
  puts '---> Inlining stylesheets...'
  Dir["public/**/*.html"].each do |f|
    puts "     Processing #{f}..."
    system "node_modules/.bin/inline-stylesheets #{f} #{f}"
  end
  puts '---> Minifying html/css/js with html-minifier...'
  system minify_cmd
end

desc 'Watch the site and regenerate when it changes'
task :watch do
  puts 'Starting to watch source with Jekyll and Compass.'
  # system "compass compile --css-dir #{source_dir}/stylesheets"
  system "node_modules/.bin/sass scss/:source/stylesheets/"
  jekyllPid = Process.spawn({ 'OCTOPRESS_ENV'=>'preview' }, 'jekyll build --watch')
  # compassPid = Process.spawn('compass watch')
  compassPid = Process.spawn('node_modules/.bin/sass scss/:source/stylesheets/ --watch')

  trap('INT') {
    [jekyllPid, compassPid].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  }

  [jekyllPid, compassPid].each { |pid| Process.wait(pid) }
end

desc 'preview the site in a web browser'
task :preview do
  puts "Starting to watch source with Jekyll and Compass. Starting Rack on port #{server_port}"
  # system "compass compile --css-dir #{source_dir}/stylesheets"
  system "node_modules/.bin/sass scss/:source/stylesheets/"
  jekyllPid = Process.spawn({ 'OCTOPRESS_ENV'=>'preview' }, 'jekyll build --watch')
  # compassPid = Process.spawn('compass watch')
  compassPid = Process.spawn('node_modules/.bin/sass scss/:source/stylesheets/ --watch')
  rackupPid = Process.spawn("rackup --host #{server_host} --port #{server_port}")

  trap('INT') {
    [jekyllPid, compassPid, rackupPid].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  }

  `open http://#{server_host}:#{server_port}`

  [jekyllPid, compassPid, rackupPid].each { |pid| Process.wait(pid) }
end

# usage rake new_post[my-new-post] or rake new_post['my new post'] or rake new_post (defaults to "new-post")
desc "Begin a new post in #{source_dir}/#{posts_dir}"
task :new_post, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin('Enter a title for your post: ')
  end
  mkdir_p "#{source_dir}/#{posts_dir}"
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort('rake aborted!') if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts '---'
    post.puts 'layout: post'
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}"
    post.puts 'comments: true'
    post.puts 'categories: '
    post.puts '---'
  end
end

# usage rake new_page[my-new-page] or rake new_page[my-new-page.html] or rake new_page (defaults to "new-page.markdown")
desc "Create a new page in #{source_dir}/(filename)/index.#{new_page_ext}"
task :new_page, :filename do |t, args|
  args.with_defaults(filename: 'new-page')
  page_dir = [source_dir]
  if args.filename.downcase =~ /(^.+\/)?(.+)/
    filename, dot, extension = $2.rpartition('.').reject(&:empty?)         # Get filename and extension
    title = filename
    page_dir.concat($1.downcase.sub(/^\//, '').split('/')) unless $1.nil?  # Add path to page_dir Array
    if extension.nil?
      page_dir << filename
      filename = 'index'
    end
    extension ||= new_page_ext
    page_dir = page_dir.map! { |d| d = d.to_url }.join('/')                # Sanitize path
    filename = filename.downcase.to_url

    mkdir_p page_dir
    file = "#{page_dir}/#{filename}.#{extension}"
    if File.exist?(file)
      abort('rake aborted!') if ask("#{file} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new page: #{file}"
    open(file, 'w') do |page|
      page.puts '---'
      page.puts 'layout: page'
      page.puts "title: \"#{title}\""
      page.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
      page.puts 'comments: true'
      page.puts 'footer: true'
      page.puts '---'
    end
  else
    puts "Syntax error: #{args.filename} contains unsupported characters"
  end
end

# usage rake isolate[my-post]
desc 'Move all other posts than the one currently being worked on to a temporary stash location (stash) so regenerating the site happens much more quickly.'
task :isolate, :filename do |t, args|
  stash_dir = "#{source_dir}/#{stash_dir}"
  FileUtils.mkdir(stash_dir) unless File.exist?(stash_dir)
  Dir.glob("#{source_dir}/#{posts_dir}/*.*") do |post|
    FileUtils.mv post, stash_dir unless post.include?(args.filename)
  end
end

desc 'Move all stashed posts back into the posts directory, ready for site generation.'
task :integrate do
  FileUtils.mv Dir.glob("#{source_dir}/#{stash_dir}/*.*"), "#{source_dir}/#{posts_dir}/"
end

desc 'Clean out build and caches'
task :clean do
  rm_rf ['public', '.pygments-cache/**', '.gist-cache/**', '.sass-cache/**', 'source/stylesheets/**']
end


##############
# Deploying  #
##############

desc 'Default deploy task'
task :deploy do
  # Check if preview posts exist, which should not be published
  if File.exist?('.preview-mode')
    puts '## Found posts in preview mode, regenerating files ...'
    File.delete('.preview-mode')
    Rake::Task[:generate].execute
  end

  Rake::Task[:copydot].invoke(source_dir, public_dir)
  Rake::Task["#{deploy_default}"].execute
end

desc 'Deploy to Fly.io'
task :deploy_fly do
  system 'flyctl version update; flyctl deploy'
end

desc 'Purge cache'
task :purge_cloudflare_cache do
  if !ENV["SWD_CF_ZONE_ID"] || !ENV["SWD_CF_API_TOK"]
    puts "#######################################################################"
    puts "# WARNING: Cloudflare ENV VARS are NOT SET. Cache WILL NOT be purged! #"
    puts "#######################################################################"
    return
  end

  system "curl -X POST https://api.cloudflare.com/client/v4/zones/#{ENV['SWD_CF_ZONE_ID']}/purge_cache -H 'Content-Type: application/json' -H 'Authorization: Bearer #{ENV['SWD_CF_API_TOK']}' --data '{\"purge_everything\":true}'"
end

# Ideally this would be ran before deploying to prod,
# but since I want to test real production
# I need to actually run it after deployment.
# I would have ran it like this: bundle exec rake "smoke_test[localhost:4000]" (ugly, but works)
# But I found it much easier to hardcode the URL. Anything else is pointless.
desc 'Smoke Test'
task :smoke_test do
  system 'tests/end-to-end.sh https://simonewebdesign.it'
end

desc 'Generate website and deploy'
task gen_deploy: [:integrate, :generate, :deploy] do
end

desc 'Generate website and deploy to Fly.io'
task gen_deploy_fly: [:integrate, :generate, :deploy_fly, :purge_cloudflare_cache, :smoke_test] do
end

desc 'copy dot files for deployment'
task :copydot, :source, :dest do |t, args|
  FileList["#{args.source}/**/.*"].exclude('**/.', '**/..', '**/.DS_Store', '**/._*').each do |file|
    cp_r file, file.gsub(/#{args.source}/, "#{args.dest}") unless File.directory?(file)
  end
end

desc 'Deploy website via rsync'
task :rsync do
  exclude = ''
  if File.exist?('./rsync-exclude')
    exclude = "--exclude-from '#{File.expand_path('./rsync-exclude')}'"
  end
  puts '## Deploying website via Rsync'
  ok_failed system("rsync -avze 'ssh -p #{ssh_port}' #{exclude} #{rsync_args} #{"--delete" unless rsync_delete == false} #{public_dir}/ #{ssh_user}:#{document_root}")
end

desc 'deploy public directory to github pages'
multitask :push do
  puts '## Deploying branch to Github Pages '
  puts '## Pulling any updates from Github Pages '
  cd "#{deploy_dir}" do
    Bundler.with_clean_env { system 'git pull' }
  end
  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }
  Rake::Task[:copydot].invoke(public_dir, deploy_dir)
  puts "\n## Copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir
  cd "#{deploy_dir}" do
    system 'git add -A'
    message = "Site updated at #{Time.now.utc}"
    puts "\n## Committing: #{message}"
    system "git commit -m \"#{message}\""
    puts "\n## Pushing generated #{deploy_dir} website"
    Bundler.with_clean_env { system "git push origin #{deploy_branch}" }
    puts "\n## Github Pages deploy complete"
  end
end

desc 'Update configurations to support publishing to root or sub directory'
task :set_root_dir, :dir do |t, args|
  puts '>>> !! Please provide a directory, eg. rake config_dir[publishing/subdirectory]' unless args.dir
  if args.dir
    if args.dir == '/'
      dir = ''
    else
      dir = '/' + args.dir.sub(/(\/*)(.+)/, '\\2').sub(/\/$/, '');
    end
    rakefile = IO.read(__FILE__)
    rakefile.sub!(/public_dir(\s*)=(\s*)(["'])[\w\-\/]*["']/, "public_dir\\1=\\2\\3public#{dir}\\3")
    File.open(__FILE__, 'w') do |f|
      f.write rakefile
    end
    compass_config = IO.read('config.rb')
    compass_config.sub!(/http_path(\s*)=(\s*)(["'])[\w\-\/]*["']/, "http_path\\1=\\2\\3#{dir}/\\3")
    compass_config.sub!(/http_images_path(\s*)=(\s*)(["'])[\w\-\/]*["']/, "http_images_path\\1=\\2\\3#{dir}/images\\3")
    compass_config.sub!(/http_fonts_path(\s*)=(\s*)(["'])[\w\-\/]*["']/, "http_fonts_path\\1=\\2\\3#{dir}/fonts\\3")
    compass_config.sub!(/css_dir(\s*)=(\s*)(["'])[\w\-\/]*["']/, "css_dir\\1=\\2\\3public#{dir}/stylesheets\\3")
    File.open('config.rb', 'w') do |f|
      f.write compass_config
    end
    jekyll_config = IO.read('_config.yml')
    jekyll_config.sub!(/^destination:.+$/, "destination: public#{dir}")
    jekyll_config.sub!(/^subscribe_rss:\s*\/.+$/, "subscribe_rss: #{dir}/atom.xml")
    jekyll_config.sub!(/^root:.*$/, "root: /#{dir.sub(/^\//, '')}")
    File.open('_config.yml', 'w') do |f|
      f.write jekyll_config
    end
    rm_rf public_dir
    mkdir_p "#{public_dir}#{dir}"
    puts "## Site's root directory is now '/#{dir.sub(/^\//, '')}' ##"
  end
end

desc 'Set up _deploy folder and deploy branch for Github Pages deployment'
task :setup_github_pages, :repo do |t, args|
  if args.repo
    repo_url = args.repo
  else
    puts 'Enter the read/write url for your repository'
    puts "(For example, 'git@github.com:your_username/your_username.github.io.git)"
    puts "           or 'https://github.com/your_username/your_username.github.io')"
    repo_url = get_stdin('Repository url: ')
  end
  protocol = (repo_url.match(/(^git)@/).nil?) ? 'https' : 'git'
  if protocol == 'git'
    user = repo_url.match(/:([^\/]+)/)[1]
  else
    user = repo_url.match(/github\.com\/([^\/]+)/)[1]
  end
  branch = (repo_url.match(/\/[\w-]+\.github\.(?:io|com)/).nil?) ? 'gh-pages' : 'main'
  project = (branch == 'gh-pages') ? repo_url.match(/\/([^\.]+)/)[1] : ''
  unless (`git remote -v` =~ /origin.+?octopress(?:\.git)?/).nil?
    # If octopress is still the origin remote (from cloning) rename it to octopress
    system 'git remote rename origin octopress'
    if branch == 'main'
      # If this is a user/organization pages repository, add the correct origin remote
      # and checkout the source branch for committing changes to the blog source.
      system "git remote add origin #{repo_url}"
      puts "Added remote #{repo_url} as origin"
      system 'git config branch.main.remote origin'
      puts 'Set origin as default remote'
      system 'git branch -m main source'
      puts "Main branch renamed to 'source' for committing your blog source files"
    else
      unless !public_dir.match("#{project}").nil?
        system "rake set_root_dir[#{project}]"
      end
    end
  end
  jekyll_config = IO.read('_config.yml')
  jekyll_config.sub!(/^url:.*$/, "url: #{blog_url(user, project)}")
  File.open('_config.yml', 'w') do |f|
    f.write jekyll_config
  end
  rm_rf deploy_dir
  mkdir deploy_dir
  cd "#{deploy_dir}" do
    system 'git init'
    system "echo 'My Octopress Page is coming soon &hellip;' > index.html"
    system 'git add .'
    system 'git commit -m "Octopress init"'
    system 'git branch -m gh-pages' unless branch == 'main'
    system "git remote add origin #{repo_url}"
    rakefile = IO.read(__FILE__)
    rakefile.sub!(/deploy_branch(\s*)=(\s*)(["'])[\w-]*["']/, "deploy_branch\\1=\\2\\3#{branch}\\3")
    rakefile.sub!(/deploy_default(\s*)=(\s*)(["'])[\w-]*["']/, 'deploy_default\\1=\\2\\3push\\3')
    File.open(__FILE__, 'w') do |f|
      f.write rakefile
    end
  end
  puts "\n---\n## Now you can deploy to #{repo_url} with `rake deploy` ##"
end

def ok_failed(condition)
  if (condition)
    puts 'OK'
  else
    puts 'FAILED'
  end
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def blog_url(user, project)
  url = if File.exist?('source/CNAME')
    "http://#{IO.read('source/CNAME').strip}"
  else
    "http://#{user}.github.io"
  end
  url += "/#{project}" unless project == ''
  url
end

desc 'list tasks'
task :list do
  puts "Tasks: #{(Rake::Task.tasks - [Rake::Task[:list]]).join(', ')}"
  puts "(type rake -T for more detail)\n\n"
end
