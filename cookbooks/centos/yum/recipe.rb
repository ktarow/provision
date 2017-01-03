YUM_GROUP_PACKAGES = [
  'Development tools'
]

YUM_PACKAGES = [
  'git',
  'vim',
  'tmux',
  'ncurses-devel',
  'curl-devel',
  'expat-devel',
  'gettext-devel',
  'openssl-devel',
  'zlib-devel',
  'readline-devel',
  'perl-ExtUtils-MakeMaker',
  'znc',
  'lua',
  'lua-devel',
  'ruby-devel'
]

execute 'yum -y update'

execute 'add epel repository' do
  command <<-EOS
    yum install -y epel-release
    sed -ri 's/enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo
  EOS
  not_if '[ -e /etc/yum.repos.d/epel.repo ]'
end

execute "yum groupinstall -y #{YUM_GROUP_PACKAGES.join(" ")}"
execute "yum install -y --enablerepo=epel #{YUM_PACKAGES.join(" ")}"
