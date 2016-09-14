VERSION="3.2.3"
REDIS_PATH="http://download.redis.io/releases/redis-#{VERSION}.tar.gz"

execute "curl #{REDIS_PATH} -o /tmp/redis.tar.gz"
execute "tar xzf /tmp/redis.tar.gz -C /opt"
execute "install" do
  command <<-EOS
    cd /opt/redis-#{VERSION} && make && make install
  EOS
  not_if "[ -e /var/run/redis_*.pid ]"
end
