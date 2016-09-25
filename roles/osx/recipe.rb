# role osx clean install

BREW_PACKAGES = [
  'vim --override-system-vi --with-lua --with-python3',
  'zsh',
  'tmux',
  'weechat'
]

BREW_CASK_PACKAGES = [
  'iterm2',
  'karabiner',
  'slack',
  'virtualbox',
  'vagrant',
  'alfred',
  'shiftit',
  'vlc'
]

BREW_TAP = [
  'caskroom/cask'
]

execute 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' do
  not_if 'which brew'
end

BREW_PACKAGES.each do |pkg|
  execute "brew install #{pkg}" do
    only_if "brew info #{pkg} | grep -qi 'Not Installed'"
  end
end

BREW_TAP.each do |pkg|
  execute "brew tap" do
    command <<-EOS
      brew tap #{pkg}
    EOS
  end
end

execute 'Change a login shell' do
  command <<-EOS
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s /usr/local/bin/zsh
  EOS

  not_if 'grep "/usr/local/bin/zsh" /etc/shells'
end

BREW_CASK_PACKAGES.each do |pkg|
  execute "brew cask install #{pkg}" do
end

execute 'for alfred' do
  command <<-EOS
    brew cask alfred link
  EOS
  only_if 'test -d /opt/homebrew-cask/Caskroom/alfred'
end
