include_recipe '../../cookbooks/yum/recipe.rb'
include_recipe '../../cookbooks/php/recipe.rb'
include_recipe '../../cookbooks/git/recipe.rb'
include_recipe '../../cookbooks/vim/recipe.rb'
include_recipe '../../cookbooks/rbenv/recipe.rb'
include_recipe '../../cookbooks/nvm/recipe.rb'
include_recipe '../../cookbooks/mysql/recipe.rb'
include_recipe '../../cookbooks/java/recipe.rb'

RBENV_ROOT = '/usr/local/rbenv'

# zsh
execute "chsh -s /bin/zsh #{node[:user]}"
file "/home/#{node[:user]}/.zshrc" do
  owner node[:user]
  group node[:user]
  mode '644'
end

file "/home/#{node[:user]}/.zshenv" do
  owner node[:user]
  group node[:user]
  mode '644'
end
execute "append zshenv" do
  command <<-EOS
    echo 'export RBENV_ROOT=#{RBENV_ROOT}' >> /home/#{node[:user]}/.zshenv
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/#{node[:user]}/.zshenv
    echo 'eval "$(rbenv init -)"' >> /home/#{node[:user]}/.zshenv
  EOS
end
