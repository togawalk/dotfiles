# EXPORT
set fish_greeting # Supresses fish's intro message
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
set -x PF_INFO "title os kernel wm uptime pkgs memory palette"
set -x PF_INFO "title os kernel wm uptime pkgs memory palette"

# Changing "ls" to "exa"
alias ls='exa --group-directories-first --long -all' # my preferred listing
alias lt='tree' # tree listing

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
