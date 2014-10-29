# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'Kick-It'                               # application name
set :repo_url, 'https://github.com/Itay289/Kick-It.git'   # your repo url

# need to change to master branch
set :branch, 'dev' 
set :deploy_to, "/home/deploy/#{fetch(:application)}"
set :deploy_user, 'deploy'

set :scm, :git
set :format, :pretty
set :keep_releases, 5

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

require File.expand_path('../../lib/cap-aws-ec2', __FILE__) 
set :aws_key_id, ENV['AWS_ACCESS_KEY_ID']
set :secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']
set :aws_region, 'us-west-2' 
set :ec2_project, 'Kick-It'
set :ec2_env, "production" 

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

