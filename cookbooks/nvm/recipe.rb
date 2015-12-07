# nvm
VERSION = 'v5.1.0'

git '/usr/local/nvm' do
  repository 'https://github.com/creationix/nvm.git'
  not_if 'test -d /usr/local/nvm'
end

remote_file '/etc/profile.d/nvm.sh' do
  not_if 'test -f /etc/profile.d/nvm.sh'
end
execute 'install node' do
  command <<-EOS
    . /usr/local/nvm/nvm.sh
    nvm install #{VERSION}
    nvm use #{VERSION}
    nvm alias default #{VERSION}
  EOS
  not_if "nvm version | grep #{VERSION}"
end

