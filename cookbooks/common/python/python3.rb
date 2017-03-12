PYVER = "3.6.0"
PYURI = "https://www.python.org/ftp/python/#{PYVER}/Python-#{PYVER}.tgz"

execute 'download python3' do
  command <<-EOS
    curl #{PYURI} -o /usr/local/src/Python-#{PYVER}.tgz
    tar xzf /usr/local/src/Python-#{PYVER}.tgz -C /usr/local/src
  EOS
  not_if '[ -e /usr/local/bin/python3 ]'
end

execute 'install' do
  command <<-EOS
    cd /usr/local/src/Python-#{PYVER} &&
    ./configure --prefix=/opt/python#{PYVER} &&
    make &&
    make install
  EOS
  not_if '[ -e /usr/local/bin/python3 ]'
end

execute 'symlink' do
  command <<-EOS
    ln -sf /opt/python#{PYVER}/bin/* /usr/local/bin/
  EOS
end

execute '/usr/local/bin/pip3 install -U pip'
