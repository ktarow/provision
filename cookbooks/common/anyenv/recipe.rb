ANYENV_ROOT='/opt/anyenv'

git "#{ANYENV_ROOT}" do
  repository 'https://github.com/riywo/anyenv.git'
  not_if "[ -d #{ANYENV_ROOT}]"
end

execute 'add path for bash' do
  command <<-EOS
    echo 'export ANYENV_ROOT=#{ANYENV_ROOT}' >> /etc/profile.d/anyenv.sh 
    echo 'export PATH="#{ANYENV_ROOT}/bin:$PATH"' >> /etc/profile.d/anyenv.sh
    echo 'eval "$(anyenv init -)"' >> /etc/profile.d/anyenv.sh
  EOS

  not_if '[ -f /etc/profile.d/anyenv.sh ]'
end
