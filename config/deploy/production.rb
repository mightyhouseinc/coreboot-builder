server 'coreboot.me', user: 'coreboot-builder', roles: %w(web app db), port: 3000
set :branch, 'master'
set :application, 'Coreboot_Builder'
set :deploy_to, '/home/coreboot-builder/production/'
set :rails_env, :production
# Default value for keep_releases is 5
set :keep_releases, 5
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
