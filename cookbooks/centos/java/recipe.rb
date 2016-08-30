execute 'install java' do
  command <<-EOS
    wget -N --no-check-certificate --no-cookies \
      --header "Cookie: oraclelicense=accept-securebackup-cookie" \
      http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm \
      -P /tmp && rpm -i /tmp/jdk-8u73-linux-x64.rpm
  EOS
  not_if 'java -version'
end

remote_file '/etc/profile.d/java.sh' do
  not_if '[ -e /etc/profile.d/java.sh ]'
end
