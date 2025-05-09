## Navigation options.
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.


## History options.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


## Custom simple prompt.
# The configuration below translates to the following prompt:
#   ...............................................................................%
#   <HH:MM:SS> | <CWD>
#    % <USER_PROMPT>
precmd() { printf -- '.%0.s' {1..79}; printf '%%\n'; print -rP "%B%F{green}%* | %~" }
export PROMPT=" %F{red}%%%f "


## Update terminal colors.
set-terminal-colors.sh


## Vim mode.
bindkey -v # Enable vim mode for the shell prompt.


## Completions.
# Process and enable completions.
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

# Complete hidden paths.
_comp_options+=(globdots)

# Case insensitive path-completion.
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Partial completion suggestions.
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# Define completers.
zstyle ':completion:*' completer _extensions _complete _approximate

# Cache completions for improved speed.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Highlight the current selection from completion options.
zstyle ':completion:*' menu select

# Add description to completion list groups.
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %B%d%b --%f'

# Display errors when using _approximate completer.
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %B%d%b (errors: %e) -!%f'

# Extra information and warnings for no completion matches.
zstyle ':completion:*:messages' format ' %F{purple} -- %B%d%b --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- %Bno matches found%b --%f'


## Aliases.
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

# Vim aliases.
alias vi='vim .'
alias vf='vim $(fzp)'
alias vd='vim $(fdhd | fzf)'

# Lazytools aliases.
alias lg='lazygit'
alias ld='lazydocker'


## Utility functions.
# A utility function to quickly regenerate completions for Zsh.
recompile_zsh_copmletions () {
  rm -f ~/.zcompdump
  compinit
}

