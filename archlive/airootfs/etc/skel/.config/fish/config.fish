
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    fastfetch
end

# Dragonized Aliases
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias cat='bat'
alias grep='rg'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias nano='micro'
alias vim='nvim'

# Environment
set -gx EDITOR nvim
set -gx VISUAL nvim
