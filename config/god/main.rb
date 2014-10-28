puts "RAILS_ENV is #{ENV["RAILS_ENV"]}"
config_path = File.expand_path(File.join(File.dirname(__FILE__), "../"))

God.pid_file_directory = '/home/deploy/Kick-It/shared/pids'

God.watch do |w|
  w.name = "unicorn"
  w.start = "bundle exec unicorn -c #{config_path}/unicorn.rb -E production"
  w.keepalive(memory_max: 150.megabytes, cpu_max: 50.percent)
end