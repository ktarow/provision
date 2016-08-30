
URI = 'http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm'

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

execute "install rpm" do
  command <<-EOS
    yum install -y #{URI}
    sed -ie 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
  EOS
end

package 'install mysql-community-server' do
  action :install
  name 'mysql-community-server'
  options '--enablerepo=mysql56-community'
end

service 'mysqld' do
  action [:enable, :start]
end
