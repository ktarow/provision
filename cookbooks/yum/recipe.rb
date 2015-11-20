# yum
YUM_GROUP_PACKAGES = [
  'Development tools'
]

YUM_PACKAGES = [
  'git',
  'tmux',
  'ncurses-devel'
]

execute 'yum -y update'
execute 'add epel repository' do
  command <<-EOS
    yum install -y epel-release
    sed -i -e 's/enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo
  EOS
  not_if 'test -f /etc/yum.repos.d/epel.repo'
end

YUM_GROUP_PACKAGES.each do |pkg|
  execute "yum groupinstall -y #{pkg}"
end

YUM_PACKAGES.each do |pkg|
  execute "yum install -y --enablerepo=epel #{pkg}"
end

# vim
git '/usr/local/src/vim' do
  repository 'https://github.com/vim/vim.git'
end
execute 'install vim' do
  command <<-EOS
    cd /usr/local/src/vim/src
    make && make install
  EOS
end
