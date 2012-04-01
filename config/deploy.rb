require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.2-p318'

load 'deploy/assets'

set :application, 'gmi'
set :domain, 'montessori-training-sc.com'
set :user, 'deployer'

set :scm, 'git'
set :repository,  "git://github.com/foliosus/GMI.git"
set :branch, 'master'
set :deploy_via, :remote_cache

set :use_sudo, false
set :deploy_to, "~/app"
set :group_writable, false
set :keep_releases, 3

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  after 'deploy:update', 'newrelic:notice_deployment'
  
  task :start, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :symlink_database_yml, :roles => :app do
    [:databasae, :email].each do |file|
      run "ln -s #{deploy_to}/shared/#{file}.yml #{deploy_to}/current/config/#{file}.yml"
    end
  end
  after 'deploy:symlink', 'deploy:symlink_database_yml'
  
  # task :restart_delayed_job, :roles => :app do
  #   run 'sudo restart delayed_job2'
  # end
  # after 'deploy:start', 'deploy:restart_delayed_job'
  # after 'deploy:restart', 'deploy:restart_delayed_job'
end