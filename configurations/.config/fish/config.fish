set -gx DOTFILES "$HOME/dotfiles" # Personal env. vars.
set -gx DEVSPACE "$HOME/dev"
set -gx PROJECTS "$DEVSPACE/projects"
set -gx PERSONAL_PROJECTS "$PROJECTS/personal"
set -gx WORK_PROJECTS "$PROJECTS/work"

set -gx XDG_CONFIG_HOME "$HOME/.config" # MacOS doesn't set XDG vars on its own 😔
set -gx XDG_DATA_HOME "$XDG_CONFIG_HOME/local/share"
set -gx XDG_CACHE_HOME "$XDG_CONFIG_HOME/cache"

set -gx FZF_DEFAULT_COMMAND 'fd . --hidden --exclude ".git"' # Fzf.
set -gx FZF_WITH_PREVIEW_OPTS "--style=minimal \
    --layout=default
    --height 100% \
    --ansi \
    --preview-window 'right:50%' \
    --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
    --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
set -gx FZF_DEFAULT_OPTS "$FZF_WITH_PREVIEW_OPTS"
set -gx FZF_CTRL_R_OPTS "--preview=''"
set -gx FZF_ALT_C_OPTS "--preview=''"

set -gx SDKMAN_DIR "$HOME/.sdkman" # SDKMan! + JVM.
set -gx JAVA_HOME "$SDKMAN_DIR/candidates/java/current"
set -gx M2_HOME "$SDKMAN_DIR/candidates/maven/current"

set -gx GOKU_EDN_CONFIG_FILE "$XDG_CONFIG_HOME/karabiner/karabiner.edn" # Goku for Karabiner.

source ~/secret_exports.fish # 🤫

# Path stuff.
set PATH $PATH "$HOME/.local/bin" # For personal stowed shell scripts.
set PATH $PATH "$HOME/.cargo/bin" # 🦀.
set PATH $PATH "$HOME/.cargo/env"
set PATH $PATH "$HOME/go/bin" # 🐹 (pretend this is a gopher).
set PATH $PATH "/Applications/Docker.app/Contents/Resources/bin" # 🐳
set PATH $PATH "/Applications/IntelliJ IDEA.app/Contents/MacOS" # 💡

/opt/homebrew/bin/brew shellenv | source # 🏠🍺

if status is-interactive
    starship init fish | source # Source starship.

    # Basic remaps.
    bind --mode=default \co edit_command_buffer # [O]pen in $EDITOR.
    bind --mode=insert \co edit_command_buffer
    bind --mode=insert \cy accept-autosuggestion # Vim-like accept.
    bind --mode=insert \cn complete # [N]ext completion.
    bind --mode=insert \cp complete-and-search # [P]revious completion.
    # [C]ancel completion or current command line.
    bind --mode=insert \cc '
    if commandline -P
        commandline -f cancel
    else
        commandline -f cancel-commandline
    end
    '

    source /opt/homebrew/opt/fzf/shell/key-bindings.fish # Fzf integration.
    fzf_key_bindings
    bind --mode=insert \cf fzf-cd-widget # [F]orward cd.
    bind --mode=insert \cb fzf-cd-backward-widget # [B]ackward cd.

    # Aliases.
    abbr --add cp 'cp -i' # Require confirmation for the following commands.
    abbr --add mv 'mv -i'
    abbr --add rm 'rm -i'

    abbr --add ls eza # List files/directories.
    abbr --add la 'eza -a'
    abbr --add ll 'eza -l'
    abbr --add lt 'eza --tree'

    abbr --add cat bat # Replace cat with bat.

    abbr --add rg 'rg --color=auto' # Always colorize ripgrep output.

    abbr --add lg lazygit # Lazytools aliases.
    abbr --add ld lazydocker
end
