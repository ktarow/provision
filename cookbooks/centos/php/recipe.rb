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

case node[:platform_version]
when '6.8'
  execute 'add remi repository' do
    command <<-EOS
      rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    EOS
    not_if '[ -e /etc/yum.repos.d/remi.repo ]'
    not_if '[ -e /etc/yum.repos.d/remi-safe.repo ]'
    not_if '[ -e /etc/yum.repos.d/remi-php70.repo ]'
  end
when '7.2'
  execute 'add remi repository' do
    command <<-EOS
      rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    EOS
    not_if '[ -e /etc/yum.repos.d/remi.repo ]'
    not_if '[ -e /etc/yum.repos.d/remi-safe.repo ]'
    not_if '[ -e /etc/yum.repos.d/remi-php70.repo ]'
  end
end

execute "yum install -y --enablerepo=epel,remi,remi-php70 #{PACKAGES.join(" ")}" do
  PACKAGES.each do |package|
    not_if "yum list installed | grep #{package}"
  end
end

execute 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer'
