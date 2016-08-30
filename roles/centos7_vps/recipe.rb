include_recipe '../../cookbooks/centos/yum/recipe.rb'
include_recipe '../../cookbooks/rbenv/recipe.rb'
include_recipe '../../cookbooks/go/recipe.rb'

execute 'sed -ir "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config'

service 'sshd' do
  action :reload
end
