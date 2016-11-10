rails_env = new_resource.environment["RAILS_ENV"]
activity = (node[:opsworks][:activity] rescue nil)
Chef::Log.info("Precompiling assets for RAILS_ENV=#{rails_env}...")
Chef::Log.info("Opsworks activity=#{activity}...")

run "cd #{release_path} && bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
