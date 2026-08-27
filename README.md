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

## Packages

- `nvim` — Neovim config
- `ghostty` — Ghostty terminal config
