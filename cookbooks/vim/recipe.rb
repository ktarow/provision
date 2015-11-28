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
