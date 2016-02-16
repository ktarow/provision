PACKAGES = [
  'php',
  'php-cli',
  'php-mbstring',
  'php-xml',
  'php-pdo',
  'php-pdo-dblib',
  'php-mysqlnd',
  'php-devel',
  'php-opcache',
  'php-gd',
  'php-mcrypt',
  'php-msgpack',
  'php-common',
  'php-pecl-xdebug',
  'php-openssl',
  'php-pecl-zip'
]

execute 'add remi repository' do
  command <<-EOS
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
  EOS
  not_if 'test -e /etc/yum.repos.d/remi.repo'
  not_if 'test -e /etc/yum.repos.d/remi-safe.repo'
  not_if 'test -e /etc/yum.repos.d/remi-php70.repo'
end

PACKAGES.each do |package|
  execute "yum install -y --enablerepo=epel,remi,remi-php70 #{package}" do
    not_if "yum list installed | grep #{package}"
  end
end

execute 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer'
