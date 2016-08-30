include_recipe '../../cookbooks/centos/yum/recipe.rb'
include_recipe '../../cookbooks/centos/php/recipe.rb'
include_recipe '../../cookbooks/centos/mysql/recipe.rb'
include_recipe '../../cookbooks/centos/java/recipe.rb'

include_recipe '../../cookbooks/common/git/recipe.rb'
include_recipe '../../cookbooks/common/vim/recipe.rb'
include_recipe '../../cookbooks/common/rbenv/recipe.rb'
include_recipe '../../cookbooks/common/nvm/recipe.rb'
