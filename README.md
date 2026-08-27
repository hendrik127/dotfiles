# dotfiles

Personal config files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

Each top-level directory is a stow "package" that mirrors the home directory
structure it should be symlinked into, e.g.:

```
nvim/.config/nvim/init.lua   ->  ~/.config/nvim/init.lua
ghostty/.config/ghostty/...  ->  ~/.config/ghostty/...
```

## Usage

Install stow:

```sh
sudo apt-get install -y stow
```

Clone this repo and symlink all packages from the repo root:

```sh
git clone https://github.com/hendrik127/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t ~ */
```

Remove all packages' symlinks:

```sh
stow -t ~ -D */
```

Note: the `bash` package only symlinks `~/.config/bash/`. It still needs two
lines in `~/.bashrc` (not tracked here, since it's a stock system file):

```sh
cat >> ~/.bashrc << 'EOF'

# Show the current git branch in the prompt (managed in ~/dotfiles)
[ -f ~/.config/bash/git-prompt.sh ] && . ~/.config/bash/git-prompt.sh

# Prefer snap-installed CLI tools (e.g. nvim v0.12+) over older apt versions
export PATH="/snap/bin:$PATH"
EOF
```

## Packages

- `nvim` — Neovim config. Requires **Neovim >= 0.12** (for `vim.pack`, the
  native plugin manager the config uses) — apt on this machine is stuck on
  0.11, so install via snap: `sudo snap install nvim --classic` (see the
  `PATH` note above). Also needs a Python `venv` module for Mason to build
  `basedpyright` — the exact apt package name tracks your `python3 --version`,
  e.g. `sudo apt-get install -y python3.14-venv`. Everything else (`ruff`,
  `basedpyright`, `nvim-lspconfig`, `telescope`, `conform`, ...) installs
  itself on first launch via `vim.pack.add` + `mason-lspconfig`'s
  `ensure_installed`. LSP (`gd`, hover) and completion are native — no
  completion plugin. `basedpyright`/`ruff` pick up the current project's
  Python interpreter automatically: an active `$VIRTUAL_ENV` wins, otherwise
  it looks for `.venv`/`venv`/`env` at the project root (covers `uv venv`'s
  default layout).
- `ghostty` — Ghostty terminal config
- `bash` — git branch in the bash prompt
- `hypr` — Hyprland config (`hyprland.conf`, `hypridle.conf`, `hyprlock.conf`,
  `hyprpaper.conf`). Core-only install on this machine: no waybar, dunst,
  rofi, thunar, wlogout, grim/slurp/swappy, or brightnessctl — the binds that
  need them are commented out in `hyprland.conf`, install the tool and
  uncomment to enable. Set a real `monitor=` line and a wallpaper in
  `~/Pictures/Wallpapers/` once you know the actual output name
  (`hyprctl monitors`).
