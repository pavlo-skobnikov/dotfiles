# Enable Starship prompt.
use ~/.cache/starship/init.nu

# 🐈
source ~/.config/nushell/theme.nu

$env.config = {
    # Disable the welcome banner at startup.
    show_banner: false

    # Options: emacs, vi.
    edit_mode: vi
    cursor_shape: {
        # Options: block, underscore, line, blink_block, blink_underscore, blink_line.
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
alias ld = list-all-subdirectories

# Replace cat with bat.
alias cat = bat

# Always colorize ripgrep output.
alias rg = rg --color=auto

# Change directories w/ fzf.
alias cf = cd (fd --type=d --hidden | fzf)

# Fzf with bat preview.
alias fzfp = fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"

# Helix.
alias hxf = hx (fzfp)
alias hxc = hx (fd --type=d --hidden | fzf)

# Lazytools
alias lg = lazygit
alias ld = lazydocker
