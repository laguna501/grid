require 'syslog-logger'

worker_processes 4
user "rails", "rails"
app_root = File.join(*%w(/srv apps grid))
current = File.join(app_root, "current")
working_directory current

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen 5001, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30
pid File.join(app_root, 'shared', 'pids', 'unicorn.pid')
logger Logger::Syslog.new("unicorn-grid", Syslog::LOG_LOCAL4)
preload_app false

stderr_path File.join(current, 'log', 'unicorn-grid.stderr.log')
stdout_path File.join(current, 'log', 'unicorn-grid.stdout.log')
