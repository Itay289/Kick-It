RAILS_ROOT = "/home/deploy/Kick-It/current"

listen 8001
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 4)
timeout 15
preload_app true

working_directory RAILS_ROOT

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

end