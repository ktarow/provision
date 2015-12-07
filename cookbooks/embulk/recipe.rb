
# embulk
execute 'curl embulk' do
  user 'vagrant'
  command <<-EOS
    curl --create-dirs -o ~/.embulk/bin/embulk -L 'http://dl.embulk.org/embulk-latest.jar'
    chmod +x ~/.embulk/bin/embulk
    echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> .zshrc
  EOS
  not_if 'witch embulk'
end
