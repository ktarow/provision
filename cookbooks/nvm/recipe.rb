# nvm
VERSION = 'v5.1.0'

git '/usr/local/nvm' do
  repository 'https://github.com/creationix/nvm.git'
end

remote_file '/etc/profile.d/nvm.sh'
execute 'install node' do
  command <<-EOS
    . /usr/local/nvm/nvm.sh
    nvm install #{VERSION}
    nvm use #{VERSION}
    nvm alias default #{VERSION}
  EOS
end

