PYURI = "https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz"
EZURI = "https://bootstrap.pypa.io/ez_setup.py"

execute 'download python3' do
  command <<-EOS
    curl #{PYURI} -o /usr/local/src/Python-3.5.2.tgz
    tar xzf /usr/local/src/Python-3.5.2.tgz -C /usr/local/src
  EOS
  not_if '[ -e /usr/local/bin/python3 ]'
end

execute 'install' do
  command <<-EOS
    cd /usr/local/src/Python-3.5.2 &&
    ./configure --prefix=/opt/python3.5 &&
    make &&
    make install
  EOS
  not_if '[ -e /usr/local/bin/python3 ]'
end

execute 'symlink' do
  command <<-EOS
    ln -s /opt/python3.5/bin/* /usr/local/bin/
  EOS
end

execute 'install easy_install' do
  command <<-EOS
    wget #{EZURI} -O - | /usr/local/bin/python3
  EOS
  not_if '[ -e /usr/local/bin/easy_install ]'
end

execute 'ln -s /opt/python3.5/bin/easy_install /usr/local/bin/'

execute 'install pip' do
  command <<-EOS
    /usr/local/bin/easy_install pip
    ln -s /opt/python3.5/bin/pip /usr/local/bin/
    /usr/local/bin/pip3 install -U pip
  EOS
  not_if '[ -e /usr/local/bin/pip ]'
end

