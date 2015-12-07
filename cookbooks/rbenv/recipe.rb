# rbenv
RBENV_ROOT='/usr/local/rbenv'
PLUGINS = {
  'ruby-build' => 'https://github.com/sstephenson/ruby-build.git',
  'rbenv-default-gems' => 'https://github.com/sstephenson/rbenv-default-gems.git',
  'rbenv-gem-rehash' => 'https://github.com/sstephenson/rbenv-gem-rehash.git'
}

RUBY='2.2.3'

git "#{RBENV_ROOT}" do
  repository 'https://github.com/sstephenson/rbenv.git' 
  not_if "test -d #{RBENV_ROOT}"
end

PLUGINS.each do |repo, uri|
  git "#{RBENV_ROOT}/plugins/#{repo}" do
    repository "#{uri}"
    not_if "test -d #{RBENV_ROOT}/plugins/#{repo}"
  end
end

execute "add /etc/profile.d/rbenv.sh" do
  command <<-EOS
    echo 'export RBENV_ROOT=#{RBENV_ROOT}' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
  EOS
  not_if 'which rbenv'
end

execute "default-gems" do
  command <<-EOS
    echo 'bundler' > #{RBENV_ROOT}/default-gems
  EOS
  not_if "test -f #{RBENV_ROOT}/default-gems"
end

# ruby
execute "install ruby" do
  command <<-EOS
    source ~/.bashrc
    rbenv install #{RUBY}
    rbenv global #{RUBY}
  EOS
  not_if "ruby -v | grep 2.2.3"
end
