namespace :deploy do

  root_dir = "/home/deploy/Kick-It"
  shared_dir = "#{root_dir}/shared"

  desc "start god."
  task :start_god do
    on roles(:app) do
      execute "#{root_dir}/current bundle exec god -c /config/god/main"
    end
  end

  desc "start god."
  task :stop_god do
    on roles(:app) do
      execute "bundle exec god terminate"
    end
  end

  desc "assets precompile"
  task :assets_precompile do
    on roles(:app) do
      execute "export RAILS_ENV=production && bundle exec rake assets:precompile"
    end
  end

  desc "bundle install"
  task :bundle_install do
    on roles(:app) do
      execute "bundle install --gemfile #{release_path}/Gemfile --path #{shared_dir}/bundle --deployment --quiet --without development test"
    end
  end

  before :deploy, "deploy:stop_god"
  after :deploy, "deploy:bundle_install" , "deploy:assets_precompile" , "deploy:start_god"

end