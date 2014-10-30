namespace :deploy do

  root_dir = "/home/deploy/Kick-It"
  shared_dir = "#{root_dir}/shared"

  desc "restart god"
  task :restart_god do
    on roles(:web) do
      within release_path do
        begin
          execute :bundle, "exec god restart"
        rescue
          execute :bundle, "exec god -c config/god/main.rb"
        end
      end
    end
  end


  desc "assets precompile"
  task :assets_precompile do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :bundle, "exec rake assets:precompile"
        end
      end
    end
  end

  desc "bundle install"
  task :bundle_install do
    on roles(:app) do
      within release_path do
        execute :bundle, "install --gemfile #{release_path}/Gemfile --path #{shared_dir}/bundle --deployment --quiet --without development test"
      end
    end
  end

end

after :deploy, "deploy:bundle_install"
after :deploy, "deploy:assets_precompile"
after :deploy, "deploy:restart_god"