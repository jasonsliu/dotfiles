# dotfiles

Minimal setup for ephemeral Linux environments, driven by
[mise](https://mise.jdx.dev). Inspired by
[chriskrycho/dotfiles](https://github.com/chriskrycho/dotfiles).

## Use

```sh
git clone <this-repo> ~/dotfiles && cd ~/dotfiles
./install.sh
```

`install.sh` installs `mise` if missing, installs pinned tools (`mise install`),
then runs `mise run setup`.

## What `setup` does

| Task | Does |
|------|------|
| `setup:shell` | Installs oh-my-zsh + the `zsh-autosuggestions` plugin |
| `setup:rtk`   | Installs [rtk](https://github.com/rtk-ai/rtk) and runs `rtk init -g` (Claude Code hook) |
| `setup:link`  | Symlinks everything under `home/` into `$HOME` |

Enabled zsh plugins (in `home/.zshrc`): `z`, `zsh-autosuggestions`, `fzf`.
`fzf` (binary) is installed via mise `[tools]`; `z` and `fzf` ship with oh-my-zsh.

## Layout

```
install.sh            bootstrap: install mise, mise install, mise run setup
mise.toml             mise config: task discovery + [tools] (fzf)
tasks/
  setup.sh            orchestrator (setup:shell, setup:rtk, setup:link)
  setup/shell.sh      oh-my-zsh + zsh-autosuggestions
  setup/rtk.sh        rtk + Claude Code wiring
  setup/link.sh       the symlink engine
home/                 mirror of $HOME — every file is symlinked into place
  .zshrc
```

## Adding a dotfile

Drop it under `home/` at its `$HOME`-relative path, then re-run the linker:

```sh
mkdir -p home/.config/nvim
cp ~/.config/nvim/init.lua home/.config/nvim/init.lua
mise run setup:link
```

By default the linker **skips** existing real files so nothing is clobbered. To
replace one with the repo's version (a diff is shown first):

```sh
mise run setup:link -- --force
```

## Handy

```sh
mise tasks              # list all tasks
mise run setup          # full provision
mise run setup:link     # (re)link dotfiles only
```
