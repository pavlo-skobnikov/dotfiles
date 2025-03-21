# Enable Starship prompt.
use ~/.cache/starship/init.nu

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

# Change directories w/ fzf.
alias cf = cd (fdhd | fzf)

# Fzf with bat preview.
alias fzp = fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"

# Vim.
alias vf = vim (fzp)
alias vd = vim (fdhd | fzf)

# Lazytools
alias lg = lazygit
alias ld = lazydocker
