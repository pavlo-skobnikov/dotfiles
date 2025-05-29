# NOTE TO SELF: To profile slow shell startups, wrap the configuration script
# with the following:
# zmodload zsh/zprof        # At the top of the .zshrc.
# ...
# zprof                     # At the bottom of the .zshrc.


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


## Vim mode configuration.
bindkey -v          # Enable vim mode for the shell prompt.
export KEYTIMEOUT=1 # Make the mode switch quicker.


## Keymaps configuration.
zmodload zsh/complist               # Load completion-related actions for configuration.
bindkey -M viins '^n' menu-complete # Prompt menu or move down the completion list.
bindkey -M viins '^p' up-history    # Move up the completion list.
bindkey -M viins '^y' accept-line   # Accept completion.
bindkey -M viins '^e' send-break    # Cancel completion and restore previous line state.

autoload -Uz edit-command-line          # Edit the line in $EDITOR.
zle -N edit-command-line
bindkey -M viins '^o' edit-command-line # <C-o> => [O]pen in $EDITOR.
bindkey -M vicmd '^o' edit-command-line

autoload -Uz select-bracketed select-quoted     # Add text objects for quotes and brackets
zle -N select-quoted                            # to Zsh's Vim emulation.
zle -N select-bracketed                         # NOTE: Forward search is not emulated.
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

autoload -Uz surround               # Mimic tpope's surround plugin.
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround


## Completions.
autoload -Uz compinit                               # Process and enable completions.
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

_comp_options+=(globdots) # Complete hidden paths.

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


## Custom simple prompt.
# The configuration below translates to the following prompt:
# <BLANK_NEWLINE>
#  <HH:MM:SS> | <CWD>
#   [<VIM_MODE>] % <USER_PROMPT>
precmd() { printf '\n'; print -rP "%B%F{green}%* | %~%f%b" }
export PS1=" %B[I]%b %F{red}%%%f "

set_cursor_and_vi_mode_prompt() {       # Switch cursors shapes for NORMAL and INSERT modes,
    cursor_block='\e[2 q'               # update the `VIMODE` variable, and force prompt redraw.
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            VIMODE='%B[N]%b'
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            VIMODE='%B[I]%b'
            echo -ne $cursor_beam
        fi

        export PS1=" ${VIMODE} %F{red}%%%f "
        zle reset-prompt
    }

    zle-line-init() {                   # Initialize the cursor for insert mode.
        echo -ne $cursor_beam
    }

    zle-line-finish() {                 # Reset the prompt to the starting value.
        export PS1=" %B[I]%b %F{red}%%%f "
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
    zle -N zle-line-finish
}
set_cursor_and_vi_mode_prompt           # Load the dynamic prompt.


## A startup script to update terminal colors.
set-terminal-colors.sh


## Tool setups.
sdk() {         # Lazy-load SDKMan i.e. source everything on first `sdk` invocation.
  unset -f sdk  # Taken from here: https://github.com/sdkman/sdkman-cli/issues/977#issuecomment-2127812178
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}


## Aliases.
alias cp='cp -i' # Require confirmation for the following commands.
alias mv='mv -i'
alias rm='rm -i'

alias ls='eza'   # List files/directories.
alias la='ls -a'
alias ll='ls -l'
alias lt='ls --tree'

alias fdhf='fd --unrestricted --exclude ".git/" --type=file'      # fd search including hidden files/directories
alias fdhd='fd --unrestricted --exclude ".git/" --type=directory' # but excluding git folder.

alias cf='cd $(fdhd | fzf)'     # Change directories w/ Fzf and fd.
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

alias cat='bat' # Replace cat with bat.

alias rg='rg --color=auto' # Always colorize ripgrep output.

# Fzf configuration alias.
alias fzp='fzf \
    --style=minimal \
    --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
    --preview "bat --color=always --style=numbers --line-range=:500 {}"'

alias vi='vim .' # Vim aliases.
alias vf='vim $(fzp)'
alias vd='vim $(fdhd | fzf)'

alias lg='lazygit' # Lazytools aliases.
alias ld='lazydocker'


## Utility functions.
recompile_zsh_completions () { # A utility function to quickly regenerate completions for Zsh.
  rm -f ~/.zcompdump
  compinit
}

