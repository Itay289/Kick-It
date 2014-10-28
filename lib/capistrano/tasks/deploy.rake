namespace :deploy do

  desc "Makes sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

 
    desc "start god."
    task :start do
      on roles(:app) do
        execute "bundle exec god -c /config/god/main"
      end
    end

  before :deploy, "deploy:check_revision"
  after :deploy, "deploy:start"
  after :rollback, "deploy:start"

end