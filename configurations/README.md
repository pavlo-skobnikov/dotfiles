# Configurations

This directory contains all my tool configurations.

- This directory gets `stow`-ed to the `$HOME` directory.

## [Alacritty](./.config/alacritty/)

Nothing special; just a straightforward, no-nonsense terminal emulator
configuration:

- on start, creates a `nu` shell, which then connects to a Tmux `home` session,
  creating it if necessary;
- a custom theme is also there.

## [Tmux](./.tmux.conf)

No plugin configuration of Tmux:

- `nu` as the Tmux's interactive shell;
- a simple and clean statusline;
- `vi` copy mode with additional mappings for visual selections & yanking;
- a few custom convenient mappings for fuzzy session management and pane/window
  management.

## [Nushell](./.config/nushell/)

Really basic setup with a few convenient aliases, vim mode, and a custom theme.

## [Starship](./.config/starship.toml)

Basically the default provided configuration file.

## [Zsh](./.zshrc)

It's only used by Intellij IDEA for running various tasks. The configuration
basically sources Nushell's environment and that's it.

## [Vim](./.vimrc)

Sane configuration for Vim as a terminal text editor:

- custom theme based on the current shell's theme;
- more pleasant native statusline;
- options to make Vim resemble modern code editors;
- better Netrw setup.

## Intellij IDEA

Two configuration files:

- [.ideavimrc](./.ideavimrc)
- [.atamanrc.config](./.atamanrc.config)

> NOTE: IdeaVim is setup to also source the basic [.vimrc](./.vimrc)
  configuration file.

The plugins I use:

- [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim);
- [Vim FunctionTextObj](https://plugins.jetbrains.com/plugin/25897-vim-functiontextobj);
- [Harpooner](https://plugins.jetbrains.com/plugin/21796-harpooner);
- [Vertical Align](https://plugins.jetbrains.com/plugin/13382-vertical-align);
- [Ataman](https://plugins.jetbrains.com/plugin/17567-ataman);
- [Github Copilot](https://plugins.jetbrains.com/plugin/17718-github-copilot).

## [Karabiner](./.config/karabiner/)

I'm using [goku](https://github.com/yqrashawn/GokuRakuJoudo) to auto-generate
the [karabiner.json](./.config/karabiner/karabiner.json) file. So, if you want
to referency my configuration, you should look at the `goku` configuration file
[here](./.config/karabiner/karabiner.edn).

