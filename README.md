
# Dotfiles Setup with GNU Stow

This repository contains dotfiles managed using [GNU Stow](https://www.gnu.org/software/stow/). Follow the steps below to set up your environment.

## Prerequisites
Ensure that GNU Stow is installed on your system:

- **Ubuntu/Debian:** `sudo apt install stow`
- **macOS (Homebrew):** `brew install stow`
- **Arch Linux:** `sudo pacman -S stow`

## Installation

1. Clone this repository:
   ```sh
   git clone --recursive <your-dotfiles-repo>
   cd dotfiles
   ```

2. Run `stow` to create symlinks for all configurations:
   ```sh
   stow *
   ```

3. If your repository includes submodules (e.g., for Vim plugins or custom scripts), initialize and update them:
   ```sh
   git submodule update --init --remote --recursive
   ```

## Uninstalling
To remove all symlinks:
```sh
for dir in */; do stow -D "$dir"; done
```

## Customizing
- If you want to selectively install configurations, run:
  ```sh
  stow bash vim git  # Example: Only install bash, vim, and git configs
  ```
- To target a specific directory (e.g., `/etc/` for system-wide configs):
  ```sh
  stow -t /etc bash
  ```

## Troubleshooting
- If symlinks aren't created as expected, check for existing conflicting files:
  ```sh
  ls -la ~ | grep <filename>
  ```
- If conflicts exist, back up and remove the files before running `stow` again:
  ```sh
  mv ~/.bashrc ~/.bashrc.backup
  ```

## License
This setup is free to use and modify.

