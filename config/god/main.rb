config_path = File.expand_path(File.join(File.dirname(__FILE__), "../"))

God.pid_file_directory = '/home/deploy/Kick-It/shared/pids'

God.watch do |w|
  pid_file = "#{God.pid_file_directory}/unicorn.pid"
  
  w.name = "unicorn"
  w.start = "bundle exec unicorn -c #{config_path}/unicorn.rb -E #{ENV["RAILS_ENV"]} -D"
  w.restart = "kill -s USR2 $(cat #{pid_file})"
  w.keepalive(memory_max: 150.megabytes, cpu_max: 50.percent)

  w.pid_file = pid_file
  w.behavior(:clean_pid_file)
end