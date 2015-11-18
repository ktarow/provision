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

execute 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"'
BREW_CASK_PACKAGES.each do |pkg|
  execute "brew cask install #{pkg}"
end

execute 'Change a login shell' do
  command <<-EOS
    sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
    chsh -s /usr/local/bin/zsh
  EOS

  not_if 'grep "/usr/local/bin/zsh" /etc/shells'
end

git "#{ENV['HOME']}/dotfiles" do
  repository 'git@github.com:ktarow/dotfiles'

  not_if "test -d '#{ENV['HOME']}/dotfiles'"
end
