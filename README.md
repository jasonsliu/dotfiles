# dotfiles

Minimal setup for ephemeral Linux environments, driven by
[mise](https://mise.jdx.dev). Inspired by
[chriskrycho/dotfiles](https://github.com/chriskrycho/dotfiles).

## Use

```sh
git clone <this-repo> ~/dotfiles && cd ~/dotfiles
./install.sh
```

`install.sh` installs `mise` if missing, then runs `mise run setup`.

## What `setup` does

| Task | Does |
|------|------|
| `setup:shell` | Installs oh-my-zsh + `zsh-autosuggestions`, installs `fzf` globally (`mise use -g`), sets zsh as the default shell (`chsh`) |
| `setup:rtk`   | Installs [rtk](https://github.com/rtk-ai/rtk) and runs `rtk init -g` (Claude Code hook) |
| `setup:link`  | Symlinks everything under `home/` into `$HOME` |

Enabled zsh plugins (in `home/.zshrc`): `z`, `zsh-autosuggestions`, `fzf`.
`z` and the `fzf` plugin ship with oh-my-zsh; the `fzf` binary is a global mise
tool so it's on `PATH` in every shell. `chsh` takes effect on next login — run
`exec zsh` to switch immediately.

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

If a real file is already in the way (e.g. an image's default `~/.zshrc`), the
linker moves it to `<file>.bak` and then symlinks — so your dotfiles always win
on a fresh box, and the original is recoverable. Re-runs are idempotent.

## Handy

```sh
mise tasks              # list all tasks
mise run setup          # full provision
mise run setup:link     # (re)link dotfiles only
```
