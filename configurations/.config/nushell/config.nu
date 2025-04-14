# Enable Starship prompt.
use ~/.cache/starship/init.nu

# Set terminal colors.
if "" == (defaults read -g AppleInterfaceStyle | complete | get stdout) {
  ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
  $env.BAT_THEME = "Catppuccin Latte"
  source ~/.config/nushell/themes/light_theme.nu
} else {
  ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
  $env.BAT_THEME = "Catppuccin Frappe"
  source ~/.config/nushell/themes/dark_theme.nu
}

touch ~/.config/alacritty/alacritty.toml

$env.config = {
    # Disable the welcome banner at startup.
    show_banner: false

    # Emacs? Not in my shell!
    edit_mode: 'vi'
    cursor_shape: {
      vi_insert: line
      vi_normal: block
    }

    # Steal fish's completions 🌚
    completions: {
        external: {
            enable: true
            max_results: 100
            completer: {|spans|
                fish --command $'complete "--do-complete=($spans | str join " ")"'
                | from tsv --flexible --noheaders --no-infer
                | rename value description
            }
        }
    }
}


## Aliases

# Require confirmation for the following commands.
alias cp = cp -i
alias mv = mv -i
alias rm = rm -i

# List files/directories.
alias la = ls -a
alias ll = ls -l
def list-all-subdirectories [] { ls -a **/* | where type == dir }
alias ldirs = list-all-subdirectories

# Replace cat with bat.
alias cat = bat

# Always colorize ripgrep output.
alias rg = rg --color=auto

# fd search including hidden files/directories but excluding git folder.
alias fdhf = fd --unrestricted --exclude '.git/' --type=file
alias fdhd = fd --unrestricted --exclude '.git/' --type=directory

# Fzf.
alias fzp = fzf --style=minimal --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview "bat --color=always --style=numbers --line-range=:500 {}"

# Change directories w/ fzf.
alias cf = cd (fdhd | fzf)

# Vim.
alias vf = vim (fzp)
alias vd = vim (fdhd | fzf)

# Lazytools
alias lg = lazygit
alias ld = lazydocker
