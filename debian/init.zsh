#zsh -c "$(wget https://raw.githubusercontent.com/crystalsis/someofmyconfig/master/debian/init.zsh -O -)"
#antigen
mkdir ~/.local/share/ -p
curl -fsSL git.io/antigen > ~/.local/share/antigen.zsh
#zplug
curl -fsSL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
#zgen
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
# .zshrc
rm -f .zshrc
cat <<EOF >~/.zshrc
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
export TERM="xterm-256color"
export ZSH="/home/jakaz/.oh-my-zsh"
export LANG=zh_CN.UTF-8

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=7
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
HIST_STAMPS="yyyy-mm-dd"

#omz
source $ZSH/oh-my-zsh.sh
#antigen
source ~/.local/share/antigen.zsh
#zplug
source ~/.zplug/init.zsh
#zgen
source "${HOME}/.zgen/zgen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

# Tell Antigen that you're done.
antigen apply
EOF
#antibody
curl -sL git.io/antibody | sh -s
#oh-my-fish
curl -L https://get.oh-my.fish | fish