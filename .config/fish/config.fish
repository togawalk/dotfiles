# set -x PATH "$HOME/.emacs.d/bin:$PATH"
set -U fish_user_paths $HOME/.emacs.d/bin $fish_user_paths
# bare git repo alias for dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
