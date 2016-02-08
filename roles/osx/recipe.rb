# role osx clean install

BREW_PACKAGES = [
  'vim --override-system-vi --with-lua',
  'zsh',
  'tmux',
  'brew-cask'
]

BREW_CASK_PACKAGES = [
  'dropbox',
  'duet',
  'intellij-idea-ce',
  'iterm2',
  'karabiner',
  'slack',
  'skype',
  'sophos-anti-virus-home-edition',
  'virtualbox',
  'vagrant',
  'alfred',
  'shiftit',
  'google-hangouts',
  'vlc'
]

BREW_TAP = [
  'caskroom/versions'
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
a execute "brew tap" do
    command <<-EOS
      brew tap #{pkg}
    EOS
  end
end

execute 'Change a login shell' do
  command <<-EOS
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s /usr/local/bin/zsh
    echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' > #{ENV['HOME']}/.zshrc   
  EOS

  not_if 'grep "/usr/local/bin/zsh" /etc/shells'
end

BREW_CASK_PACKAGES.each do |pkg|
  execute "install cask" do
    command <<-EOS
      brew cask install #{pkg}
    EOS
  end
end

execute 'for alfred' do
  command <<-EOS
    brew cask alfred link
  EOS
  only_if 'test -d /opt/homebrew-cask/Caskroom/alfred'
end

git "#{ENV['HOME']}/dotfiles" do
  repository 'git@github.com:ktarow/dotfiles'

  not_if "test -d '#{ENV['HOME']}/dotfiles'"
end
