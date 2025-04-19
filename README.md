#  Mach - A Neovim Distribution

## Installation

### Prerequisites
- Neovim >= 0.11.0 with LuaJIT
    - If `nvim` is not found on PATH the Mach Instller will try and build the
    latest stable release from from source
    - If building from source, the following are required:
        - make
        - cmake
- Git >= 2.19.0
    - If `git` is not found on PATH, the Mach Installer will try and install with
    the system package manaager(currently on apt-get, dnf, pacman, and brew) are
    supported.
- A Nerd Font
    - If no Nerd Font is found with `fc-list`, then Jetbrains Mono NF will be
    installed automatically.
- curl
- ripgrep

### Installation
#### Automatic Mode
```bash
curl https://raw.githubusercontent.com/S-Spektrum-M/mach-nvim/main/install.sh | bash -s -- -nupig -m source
```

#### Interactive Mode
```
curl https://raw.githubusercontent.com/S-Spektrum-M/mach-nvim/main/install.sh  -o install.sh
chmod +x install.sh
./install.sh
```
