require 'bundler/capistrano'

# Global setting
default_run_options[:pty] = true
set :application, "grid"
set :repository,  "https://github.com/laguna501/grid.git"
set :deploy_via,  "export"
set :scm, :git
set :bundle_flags,    "--deployment"
set :bundle_without,  [:development, :test]
set :rake, "bundle exec rake --trace"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    # run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
    run "#{try_sudo} bluepill unicorn-grid start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} kill `cat #{unicorn_pid}`"
    run "#{try_sudo} bluepill unicorn-grid stop"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
    run "#{try_sudo} bluepill unicorn-grid stop"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
    run "#{try_sudo} bluepill unicorn-grid restart"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    sleep(10)
    start
  end

  desc <<-DESC
    Run the create rake task. By default, it runs this in most recently \
    deployed version of the app. However, you can specify a different release \
    via the migrate_target variable, which must be one of :latest (for the \
    default behavior), or :current (for the release indicated by the \
    `current' symlink). Strings will work for those values instead of symbols, \
    too. You can also specify additional environment variables to pass to rake \
    via the create_env variable. Finally, you can specify the full path to the \
    rake executable by setting the rake variable. The defaults are:

      set :rake,           "rake"
      set :rails_env,      "production"
      set :create_env,     ""
      set :migrate_target, :latest
  DESC
  task :create, :roles => :db do
    migrate_env = fetch(:create_env, "")
    migrate_target = fetch(:migrate_target, :latest)

    directory = case migrate_target.to_sym
      when :current then current_path
      when :latest  then latest_release
      else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
      end

    run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:create"
  end

  desc <<-DESC
    Deploys and starts a `cold' application. This is useful if you have not \
    deployed your application before, or if your application is (for some \
    other reason) not currently running. It will deploy the code, create the database, \
    run any pending migrations, and then instead of invoking `deploy:restart', it will \
    invoke `deploy:start' to fire up the application servers.
  DESC
  task :cold do
    update
    create
    migrate
    start
  end

  desc <<-DESC
    Seed the data in the database. This is use for the data migration. \
    Rewrite the db/seeds.rb for new data migration each release.
  DESC
  task :seed, :roles => :db do
    run "cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} db:seed"
  end
end

desc <<-EOS
Configure cap run for production environment
EOS
task :production do
  set :user, "rails"
  set :group, "rails"
  set :rails_env, :production
  set :deploy_to, File.join(*%W(/srv apps #{application}))
  set :unicorn_binary, "bundle exec unicorn"
  set :unicorn_config, File.join(current_path, 'config', 'unicorn', 'production.rb')
  set :unicorn_pid, File.join(current_path, 'tmp', 'pids', 'unicorn.pid')
  set :assets_prefix, "grid"
  set(:branch) { Capistrano::CLI.ui.ask("Tag to deploy:") }

  role :web, "grid.canonlife.com"                    # Your HTTP server, Apache/etc
  role :app, "grid.canonlife.com"                    # This may be the same as your `Web` server
  role :db,  "grid.canonlife.com", :primary => true  # This is where Rails migrations will run
end

desc <<-EOS
Configure cap run for staging environment
EOS
task :staging do
  set :user, "rails"
  set :group, "rails"
  set :rails_env, :staging
  set :deploy_to, File.join(*%W(/srv apps #{application}))
  set :unicorn_binary, "bundle exec unicorn"
  set :unicorn_config, File.join(current_path, 'config', 'unicorn', 'staging.rb')
  set :unicorn_pid, File.join(current_path, 'tmp', 'pids', 'unicorn.pid')
  set :assets_prefix, "grid"
  set(:branch) { Capistrano::CLI.ui.ask("Tag to deploy:") }

  role :web, "grid.swiftlet.co.th"                    # Your HTTP server, Apache/etc
  role :app, "grid.swiftlet.co.th"                    # This may be the same as your `Web` server
  role :db,  "grid.swiftlet.co.th", :primary => true  # This is where Rails migrations will run
end
