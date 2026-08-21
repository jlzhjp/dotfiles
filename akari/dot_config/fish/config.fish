# mise must be initialized before mise-managed tools are used below.
if type -q mise
    mise activate fish | source
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'
set -gx CC clang
set -gx CXX clang++
set -gx MAMBA_ROOT_PREFIX "$HOME/.local/share/mamba"
set -gx SSH_AUTH_SOCK "$HOME/.bitwarden-ssh-agent.sock"

if type -q direnv
    direnv hook fish | source
end

if type -q starship
    starship init fish | source
end

if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

abbr --add gs 'git status --short'
abbr --add nf 'nix flake update'

alias cat bat
alias df 'df -h'
alias diff 'diff --color=auto'
alias du 'du -h'
alias grep 'grep --color=auto'
alias la 'eza --all --group-directories-first --git --long'
alias ll 'eza --group-directories-first --git --long'
alias ls 'eza --group-directories-first'
alias tree 'eza --tree'
alias vi 'nvim --clean'
alias bwu 'set -gx BW_SESSION (bw unlock --raw)'
alias bwl 'bw lock; set -e BW_SESSION'
