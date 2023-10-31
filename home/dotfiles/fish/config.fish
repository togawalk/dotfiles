# EXPORT
set fish_greeting # Supresses fish's intro message
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
set -x PF_INFO "title os kernel wm uptime pkgs memory palette"
set -x PF_INFO "title os kernel wm uptime pkgs memory palette"

set EDITOR "nvim" # $EDITOR use Neovim in terminal
set VISUAL "nvim" # $VISUAL use Neovim in GUI mode

# Changing "ls" to "exa"
alias ls='exa --group-directories-first --long -all --git --no-permissions --header' # my preferred listing
alias lt='tree' # tree listing

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias cat='bat -p'

alias tty-clock='tty-clock -c'


if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
