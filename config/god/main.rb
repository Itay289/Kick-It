config_path = File.expand_path(File.join(File.dirname(__FILE__), "../"))

God.watch do |w|
  w.name = "unicorn"
  w.start = "bundle exec unicorn -c #{config_path}/unicorn.rb"
  w.keepalive(memory_max: 150.megabytes, cpu_max: 50.percent)
end