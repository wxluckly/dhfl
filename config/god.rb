rails_env = ENV['RAILS_ENV'] || 'production'
rails_root = ENV['RAILS_ROOT'] || "/www/dhfl/current"

God.watch do |w|
  w.name = "dhfl"
  w.interval = 30.seconds # default

  w.env = {"RAILS_ENV"=>rails_env}

  w.start = "cd #{rails_root} && bundle exec puma --config #{rails_root}/config/puma.rb -e #{rails_env} -d"

  w.stop = "kill -TERM `cat #{rails_root}/tmp/pids/puma.pid`"

  w.restart = "kill -USR1 `cat #{rails_root}/tmp/pids/puma.pid`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "#{rails_root}/tmp/pids/puma.pid"

  w.log = "#{rails_root}/log/god.out.log"

  w.keepalive( :memory_max => 200.megabytes )

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 200.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end
  end
end
