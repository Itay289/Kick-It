namespace :deploy do

  root_dir = "/home/deploy/Kick-It"
  shared_dir = "#{root_dir}/shared"
  current_path = "#{root_dir}/current"

  desc "start god"
  task :start_god do
    on roles(:web) do
      with rails_env: fetch(:stage) do
        within release_path do
          execute :bundle, "exec god -c config/god/main.rb"
        end
      end
    end
  end

  desc "stop god"
  task :stop_god do
    on roles(:web) do
      within release_path do
        begin
          execute :bundle, "exec god terminate"
        rescue
          info " god already stopped"
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
        execute "bundle install --gemfile #{release_path}/Gemfile --path #{shared_dir}/bundle --deployment --quiet --without development test"
      end
    end
  end

end

before :deploy, "deploy:stop_god"
after :deploy, "deploy:bundle_install"
after :deploy, "deploy:assets_precompile"
after :deploy, "deploy:start_god"