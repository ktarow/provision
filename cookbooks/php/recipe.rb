# php
package 'epel-release' do
  options '-y'
end

execute 'add remi' do
  command <<-EOS
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
  EOS
  not_if 'test -e /etc/yum.repos.d/remi.repo'
end

package 'php' do
  options '--enablerepo=remi-php56 -y'
end
