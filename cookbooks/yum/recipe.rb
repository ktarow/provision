# yum
YUM_GROUP_PACKAGES = [
  'Development tools'
]

YUM_PACKAGES = [
  'git',
  'tmux',
  'ncurses-devel',
  'zsh',
  'curl-devel',
  'expat-devel',
  'gettext-devel',
  'openssl-devel',
  'zlib-devel',
  'perl-ExtUtils-MakeMaker'
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