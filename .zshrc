# NOTE TO SELF: To profile slow shell startups, wrap the configuration script
# with the following:
# zmodload zsh/zprof        # At the top of the .zshrc.
# ...
# zprof                     # At the bottom of the .zshrc.


## [ Navigation options 🧭 ]
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.


## [ History options 📜 ]
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


## [ Completions 🧩 ]
# Add community completions.
# NOTE: Requires `zsh-completions` to be installed.
if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]; then
    fpath+=("$HOMEBREW_PREFIX/share/zsh-completions")
fi

autoload -Uz compinit

# Automatically fix insecure directories before running compinit
ZCOMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

# Recompile the completion dump file if it's older than 24 hours OR if it doesn't exist.
if [[ ! -f "$ZCOMPDUMP" ]] || [[ "$(date '+%Y-%m-%d')" != "$(stat -c '%y' "$ZCOMPDUMP" 2>/dev/null | cut -d' ' -f1)" ]]; then
    echo "Recompiling completion dump file..."
    echo "This may take a moment 😴..."

    compinit -i -d "$ZCOMPDUMP"

    # Compile a dump file for faster loading next time.
    if [[ -s "$ZCOMPDUMP" && (! -s "${ZCOMPDUMP}.zwc" || "$ZCOMPDUMP" -nt "${ZCOMPDUMP}.zwc") ]]; then
        zcompile "$ZCOMPDUMP"
    fi
else
    # Skip security checks for faster startup.
    compinit -C -d "$ZCOMPDUMP"
fi

# Complete hidden paths.
_comp_options+=(globdots)

# Disable sort when completing `git checkout`.
zstyle ':completion:*:git-checkout:*' sort false

# Set descriptions format to enable group support.
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# Set list-colors to enable filename colorizing.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix.
zstyle ':completion:*' menu no

# Preview directory's content with eza when completing cd.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin.
# Reference: Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Switch group using `<` and `>`.
zstyle ':fzf-tab:*' switch-group '<' '>'


## [ Custom simple prompt 💬 ]
local bb='%K{black} %k' # [B]lock [b]lack.
local bw='%K{white} %k' # [B]lock [w]hite.

precmd() { printf '\n'; print -rP "$bw$bb 📁 %d $bb$bw" }
export PS1=" %F{green}%%%f "

# Switch cursors shapes for NORMAL and INSERT modes.
set_cursor_and_vi_mode_prompt() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    # Initialize the cursor for insert mode.
    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

# Load the dynamic prompt.
set_cursor_and_vi_mode_prompt


## [ Vim mode configuration 💻 ]
bindkey -v
export KEYTIMEOUT=1 # Make the mode switch quicker.

# Add text objects for quotes and brackets to Zsh's Vim emulation.
autoload -Uz select-bracketed select-quoted

zle -N select-quoted
zle -N select-bracketed

for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done

# Add surround plugin.
autoload -Uz surround

zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

bindkey -M vicmd gsr change-surround
bindkey -M vicmd gsd delete-surround
bindkey -M vicmd gsa add-surround
bindkey -M visual gsa add-surround


## [ Tool setups 🧰 ]
# Fzf.
source <(fzf --zsh)

# Lazy-load SDKMan!
sdk() {
    unset -f sdk
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
}

# Lazy-load nvm.
nvm() {
    unset -f nvm
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

    nvm "$@"
}


## [ Load plugins 📦 ]
# List of plugin scripts to load.
plugins_list=(
    # `fzf-tab` plugin.
    "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
    # `fast-syntax-highlighting` plugin.
    "$HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
)

# Loop over the list of plugin scripts and source them if the file exists.
for plugin in $plugins_list; do
    # echo "Loading plugin: $plugin"
    [[ -f "$plugin" ]] && source "$plugin"
done


## [ Aliases 👤 ]
# Require confirmation for the following commands.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ls='eza'
alias la='ls -lha'
alias lt='ls --tree'

# Replace cat with bat.
alias cat='bat'

# Always colorize ripgrep output.
alias rg='rg --color=auto'

alias nvim='nvim-server'
alias vim='nvim'
alias vi='nvim'

alias lg='lazygit'
alias ld='lazydocker'


## [ Functions 🧮 ]
# Recompile the Zsh's completion dump file.
recompile-zsh-completions() {
    rm -f "$ZCOMPDUMP" "${ZCOMPDUMP}.zwc"
    compinit -i -d "$ZCOMPDUMP"
    zcompile "$ZCOMPDUMP"
}

# Recompile the `bat` theme cache.
rebuild-bat-cache() {
    bat cache --clear
    bat cache --build
}

# Generate a random alphanumeric string.
#   - $1 is the length of the random string.
gen-rand-str() {
    head -c "$1" /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | cut -c1-"$1"
}

# Set the `fast-syntax-highlighting` Zsh plugin theme.
set-fast-theme() {
    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        fast-theme XDG:catppuccin-frappe
    else
        # Default to light theme if key doesn't exist or has any other value
        fast-theme XDG:catppuccin-latte
    fi
}

# Start a Neovim server for remote commands.
nvim-server() {
    local servers_dir="/tmp/nvim"

    # Ensure the directory exists.
    mkdir -p "$servers_dir"

    # Generate a random server name.
    local server_name="nvim-server-$(gen-rand-str 16).sock"

    # Start Neovim server name and pass arguments.
    command nvim --listen "$servers_dir/$server_name" "$@"
}


## [ Keymaps configuration ⌨️ ]
# Load completion-related actions for configuration.
zmodload zsh/complist

bindkey -M viins '^n' menu-complete
bindkey -M viins '^p' reverse-menu-complete

# Edit the line in $EDITOR.
autoload -Uz edit-command-line

zle -N edit-command-line

bindkey -M viins '^o' edit-command-line
bindkey -M vicmd '^o' edit-command-line

# Fzf keymaps.
# Go [f]orward to one of the nested directories.
zle -N fzf-cd-widget
bindkey -M viins '^f' fzf-cd-widget
bindkey -M vicmd '^f' fzf-cd-widget

# Go [b]ackwards down the directory stack.
# Either 'till Tmux's session root or 'till '/'
fzf-cd-backward-widget() {
    path_array=()
    local parent_path="$(dirname $(pwd))"

    local tmux_session_path="$(tmux display-message -p '#{session_path}')"
    local stop_path
    if [[ "$parent_path" == *$tmux_session_path* ]]; then
        stop_path="$tmux_session_path"
    else
        stop_path="/"
    fi

    while [[ "$parent_path" != "$stop_path" ]]; do
        path_array+=($parent_path)

        parent_path="$(dirname $parent_path)"
    done

    path_array+=($stop_path)

    local selected_dir=$(printf "%s\n" "${path_array[@]}" | fzf --preview '')

    # Exit if nothing in selected.
    if [[ -z "$selected_dir" ]]; then
        zle redisplay
        return 0
    fi

    # `cd` and reset prompt similar to native fzf cd widget.
    zle push-line
    BUFFER="builtin cd -- ${(q)selected_dir:a}"
    zle accept-line
    local ret=$?
    zle reset-prompt
    return $ret
}
zle -N fzf-cd-backward-widget

bindkey -M viins '^b' fzf-cd-backward-widget
bindkey -M vicmd '^b' fzf-cd-backward-widget
