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
end

PLUGINS.each do |repo, uri|
  git "#{RBENV_ROOT}/plugins/#{repo}" do
    repository "#{uri}"
  end
end

execute "add /etc/bashrc" do
  command <<-EOS
    echo 'export RBENV_ROOT=#{RBENV_ROOT}' >> /etc/bashrc
    echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/bashrc
    echo 'eval "$(rbenv init -)"' >> /etc/bashrc
  EOS
end

execute "default-gems" do
  command <<-EOS
    echo 'bundler' > #{RBENV_ROOT}/default-gems
  EOS
end

# ruby
execute "install ruby" do
  command <<-EOS
    source ~/.bashrc
    rbenv install #{RUBY}
    rbenv global #{RUBY}
  EOS
end

