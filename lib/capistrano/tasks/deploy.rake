namespace :deploy do

  desc "start god."
  task :start_god do
    on roles(:app) do
      execute "bundle exec god -c /config/god/main"
    end
  end

  desc "start god."
  task :stop_god do
    on roles(:app) do
      execute "bundle exec god terminate"
    end
  end

  before :deploy, "deploy:stop_god"
  after :deploy, "deploy:start_god"

end