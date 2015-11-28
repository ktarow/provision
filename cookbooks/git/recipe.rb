# git
git '/usr/local/src/git' do
  repository 'git://git.kernel.org/pub/scm/git/git.git'
end
execute 'install git' do
  command <<-EOS
    cd /usr/local/src/git
    make prefix=/usr/local all
    make prefix=/usr/local install
  EOS
end
