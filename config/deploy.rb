set :application, "bcn"
role :web, "172.18.21.14"                          # Your HTTP server, Apache/etc
role :app, "172.18.21.14"                          # This may be the same as your `Web` server
role :db,  "172.18.21.14", :primary => true        # This is where Rails migrations will run

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/bcn"
set :deploy_via, :remote_cache
set :user, "adolfoc"
set :use_sudo, true

# repo details
set :scm, :git
set :scm_username, "adolfoc"
set :repository, "git@github.com:adolfoc/bcn.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end



# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end