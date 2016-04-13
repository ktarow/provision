include_recipe '../../cookbooks/yum/recipe.rb'
include_recipe '../../cookbooks/rbenv/recipe.rb'

execute 'sed -ir "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config'

service 'sshd' do
  action :reload
end
