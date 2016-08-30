# vim
git '/usr/local/src/vim' do
  repository 'https://github.com/vim/vim.git'
  not_if '[ -d /usr/local/src/vim ]'
end
execute 'install vim' do
  command <<-EOS
    cd /usr/local/src/vim/src
    make && make install
  EOS
  not_if 'vim --version | grep 7.4'
end
