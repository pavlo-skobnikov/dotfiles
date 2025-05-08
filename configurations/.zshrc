## Configurations.
# Setup starship prompt.
eval "$(starship init zsh)"

# Update Alacritty's current theme based on the system appearance.
if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
fi

touch ~/.config/alacritty/alacritty.toml

# Enable vim mode for the shell prompt.
bindkey -v

# Enable completion.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;
# autoload -U compinit; compinit
# _comp_options+=(globdots)
# source /usr/bin/

## Aliases
# Require confirmation for the following commands.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# List files/directories.
alias ls='eza'
alias la='ls -a'
alias ll='ls -l'
alias lt='ls --tree'

# fd search including hidden files/directories but excluding git folder.
# Using double quotes for the exclude pattern.
alias fdhf='fd --unrestricted --exclude ".git/" --type=file'
alias fdhd='fd --unrestricted --exclude ".git/" --type=directory'

# Change directories w/ fzf using fd.
alias cf='cd $(fdhd | fzf)'

cd_back_to_parent_directory() {
    local current_path=$(pwd)

    path_array=()
    local parent_path=$current_path
    while [[ "$parent_path" != $HOME ]]; do
        parent_path=${parent_path%/*}

        path_array+=($parent_path)
    done

    local selected_path=$(printf "%s\n" "${path_array[@]}" | fzf)

    if [[ -n "$selected_path" ]]; then
        cd $selected_path
    fi
}
alias cb='cd_back_to_parent_directory'

# Replace cat with bat.
alias cat='bat'

# Always colorize ripgrep output.
alias rg='rg --color=auto'

# Fzf configuration alias.
# The preview command arguments need to be quoted correctly for Zsh.
alias fzp='fzf \
    --style=minimal \
    --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
    --preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Vim aliases using fzf.
alias vf='vim $(fzp)'
alias vd='vim $(fdhd | fzf)'

# Lazytools aliases.
alias lg='lazygit'
alias ld='lazydocker'

