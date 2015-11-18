# role osx clean install

BREW_PACKAGES = [
  'vim --override-system-vi --with-lua',
  'zsh',
  'tmux',
  'caskroom/cask/brew-cask'
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

execute 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' do
  not_if 'which brew'
end

BREW_PACKAGES.each do |pkg|
  execute "brew install #{pkg}"
end

BREW_CASK_PACKAGES.each do |pkg|
  execute "brew cask install #{pkg}"
end
