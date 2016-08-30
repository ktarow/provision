
# embulk
execute 'curl embulk' do
  user 'vagrant'
  command <<-EOS
    curl --create-dirs -o ~/.embulk/bin/embulk -L 'http://dl.embulk.org/embulk-latest.jar'
    chmod +x ~/.embulk/bin/embulk
  EOS
  not_if 'test -d ~/.embulk'
end
execute 'export' do
  user 'vagrant'
  command <<-EOS
    echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> .zshenv
  EOS
  not_if 'cat ~/.zshenv | grep .embulk'
end
