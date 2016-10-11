
VERSION = '1.6.1'
FILENAME = "go#{VERSION}.linux-amd64.tar.gz"
URI = "https://storage.googleapis.com/golang/#{FILENAME}"
GOROOT = '/opt/go'
GOPATH = '$HOME/go'

execute "append GOROOT" do
  command <<-EOS
    echo 'export GOROOT=#{GOROOT}' >> /etc/profile.d/go.sh
    echo 'export PATH="$GOROOT/bin:$PATH"' >> /etc/profile.d/go.sh
  EOS
  not_if "[ -e /etc/profile.d/go.sh ]"
end

execute "append GOPATH" do
  command <<-EOS
    echo 'export GOPATH=#{GOPATH}' >> $HOME/.bash_profile
  EOS
  not_if "grep 'GOPATH' $HOME/.bash_profile"
end

execute "curl #{URI} -o /tmp/#{FILENAME}" do
  not_if "[ -d /tmp/#{FILENAME} ]"
end

execute "tar xzf /tmp/#{FILENAME} -C /opt"
