# vim
git '/usr/local/src/vim' do
  repository 'https://github.com/vim/vim.git'
end
execute 'install vim' do
  command <<-EOS
    cd /usr/local/src/vim/src
    make && make install
  EOS
end

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
