include_recipe '../../cookbooks/centos/yum/recipe.rb'
include_recipe '../../cookbooks/centos/php/recipe.rb'
include_recipe '../../cookbooks/centos/mysql/recipe.rb'
include_recipe '../../cookbooks/centos/java/recipe.rb'

include_recipe '../../cookbooks/common/git/recipe.rb'
include_recipe '../../cookbooks/common/vim/recipe.rb'
include_recipe '../../cookbooks/common/rbenv/recipe.rb'
include_recipe '../../cookbooks/common/nvm/recipe.rb'

RBENV_ROOT = '/usr/local/rbenv'

execute "append .bashrc" do
  command <<-EOS
    echo 'export RBENV_ROOT=#{RBENV_ROOT}' >> /home/#{node[:user]}/.bashrc
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/#{node[:user]}/.bashrc
    echo 'eval "$(rbenv init -)"' >> /home/#{node[:user]}/.bashrc
  EOS
end
