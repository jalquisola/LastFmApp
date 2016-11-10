Chef::Log.info('Running deploy/before_migrate.rb...')
# Assets
if !::File.exists?("#{new_resource.deploy_to}/shared/assets")
  Chef::Log.info("Creating directory #{new_resource.deploy_to}/shared/assets")
  run "mkdir #{new_resource.deploy_to}/shared/assets"
end

Chef::Log.info("Symlinking #{release_path}/public/assets to #{new_resource.deploy_to}/shared/assets")

link "#{release_path}/public/assets" do
  to "#{new_resource.deploy_to}/shared/assets"
end

## TMP files
if !::File.exists?("#{new_resource.deploy_to}/shared/tmp")
  run "mkdir #{new_resource.deploy_to}/shared/tmp"
end

Chef::Log.info("Symlinking #{release_path}/tmp to #{new_resource.deploy_to}/shared/tmp")
run "rm -rf #{release_path}/tmp"
link "#{release_path}/tmp" do
  to "#{new_resource.deploy_to}/shared/tmp"
end
