# Configurations

This directory contains all my tool configurations.

- This directory gets `stow`-ed to the `$HOME` directory.

## [Alacritty](./.config/alacritty/)

Nothing special; just a straightforward, no-nonsense terminal emulator
configuration:

- on start, creates a `zsh` shell, which then connects to a Tmux `home` session,
  creating it if necessary at $HOME;
- a custom theme is also there.

## [Tmux](./.tmux.conf)

No plugin configuration of Tmux:

- a simple and clean statusline;
- `vi` copy mode with additional mappings for visual selections & yanking;
- a few custom convenient mappings for fuzzy session management and pane/window
  management.

## [Starship](./.config/starship.toml)

Basically the default provided configuration file.

## Zsh

I took heavy inspiration *cough-cough* (more like stole configuration) from:

- [this excellent Zsh configuratioon article from the Valuable Dev](https://thevaluable.dev/zsh-install-configure-mouseless/);
- [the outstanding "Moving to zsh" series from ScriptingOSX](https://scriptingosx.com/2019/06/moving-to-zsh/);
- [this Github Gist to speed up compint](https://gist.github.com/ctechols/ca1035271ad134841284).

Two files:

- [zprofile](./.zprofile) => sets up the environment variables and $PATH.
- [zshrc](./.zshrc) => contains the rest of my configurations for the
interactive shell mode.

Some notes:

- no Zsh "framework";
- basic prompt;
- Vim mode w/ custom key maps & extra modules;
- optimized completion initalization;
- simple completion styling;
- a few aliases.

## [Vim](./.vimrc)

Sane configuration for Vim as a terminal text editor:

- custom theme based on the current system appearance;
- more pleasant native statusline;
- options to make Vim resemble modern code editors;
- a few fuzzy-searching commands;
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

