# git
git '/usr/local/src/git' do
  repository 'git://git.kernel.org/pub/scm/git/git.git'
  not_if 'test -d /usr/local/src/git'
end

execute 'install git' do
  command <<-EOS
    cd /usr/local/src/git
    make prefix=/usr/local all
    make prefix=/usr/local install
  EOS
  not_if 'which git'
end
