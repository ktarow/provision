include_recipe '../../cookbooks/yum/recipe.rb'
include_recipe '../../cookbooks/commands/recipe.rb'

# zsh
execute "chsh -s /bin/zsh #{node[:user]}"
file "/home/#{node[:user]}/.zshrc" do
  owner node[:user]
  group node[:user]
  mode '644'
end
