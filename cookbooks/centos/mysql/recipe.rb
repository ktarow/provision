
EL6 = 'http://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm'
EL7 = 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm'

package 'remove mysql' do
  action :remove
  name 'mysql-*'
  only_if 'yum list installed | grep mysql'
end

package 'remove maria*' do
  action :remove
  name 'maria*'
  only_if 'yum list installed | grep maria'
end

case node[:platform_version]
when '6.8'
  execute "install rpm" do
    command <<-EOS
    yum install -y #{EL6}
    sed -ie 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
    EOS
    not_if "yum list installed | grep -E mysql[0-9]{2}-community-release"
  end
when '7.2'
  execute "install rpm" do
    command <<-EOS
    yum install -y #{EL7}
    sed -ie 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
    EOS
    not_if "yum list installed | grep -E mysql[0-9]{2}-community-release"
  end
end

package 'install mysql-community-server' do
  action :install
  name 'mysql-community-server'
  options '--enablerepo=mysql56-community'
end

service 'mysqld' do
  action [:enable, :start]
end
