NGINX="http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"

execute "rpm -i #{NGINX}" do
  not_if "[ -e /etc/yum.repo.d/nginx.repo ]"
end

execute "yum install --enablerepo=nginx -y nginx" do
  only_if "yum list installed | grep nginx"
end

execute "copy original files" do
  command <<-EOS
    cp /etc/nginx/nginx.conf  /etc/nginx/nginx.conf.org
  EOS
end
