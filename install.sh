#!/usr/bin/env bash

# Exit on error, unset variable, and pipe failure
set -euo pipefail

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
NVIM_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
NVIM_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"
REQUIRED_NVIM_VERSION="0.9.0" # Set your minimum required version

echo "=== Neovim Installation and Configuration Setup ==="

# Function to backup directories safely
backup_directory() {
    local dir="$1"
    if [ -d "$dir" ]; then
        local backup="${dir}.bak.$(date +%Y%m%d%H%M%S)"
        echo "Backing up $dir to $backup"
        mv "$dir" "$backup"
    fi
}

# Function to check Neovim version
check_nvim_version() {
    if command -v nvim >/dev/null 2>&1; then
        local version=$(nvim --version | head -n1 | cut -d ' ' -f2)
        echo "Found Neovim version: $version"
        if [ "$(printf '%s\n' "$REQUIRED_NVIM_VERSION" "$version" | sort -V | head -n1)" != "$REQUIRED_NVIM_VERSION" ]; then
            echo "Warning: Installed Neovim version ($version) is older than the required version ($REQUIRED_NVIM_VERSION)"
            return 1
        fi
        return 0
    fi
    return 1
}

# Install Neovim if not found or version too old
install_neovim() {
    if ! check_nvim_version; then
        echo "Neovim not found or version too old."

        PS3="Please select an installation method: "
        options=("Build from source" "Use package manager" "Skip installation")
        select opt in "${options[@]}"; do
            case $opt in
                "Build from source")
                    install_from_source
                    break
                    ;;
                "Use package manager")
                    install_from_package_manager
                    break
                    ;;
                "Skip installation")
                    echo "Skipping Neovim installation."
                    break
                    ;;
                *)
                    echo "Invalid option $REPLY"
                    ;;
            esac
        done
    else
        echo "Neovim is already installed with a compatible version."
    fi
}

# Install Neovim from source
install_from_source() {
    echo "Installing build dependencies..."

    # Check if we're on Ubuntu/Debian
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl
    # Check if we're on Fedora/RHEL/CentOS
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch curl
    # Check if we're on Arch
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S base-devel cmake unzip ninja curl
    # macOS with Homebrew
    elif command -v brew >/dev/null 2>&1; then
        brew install ninja libtool automake cmake pkg-config gettext curl
    else
        echo "Could not detect package manager. Please install build dependencies manually."
        read -p "Continue anyway? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 1
        fi
    fi

    echo "Cloning Neovim repository..."
    local temp_dir=$(mktemp -d)
    git clone https://github.com/neovim/neovim.git "$temp_dir" --depth=1 --branch=stable

    echo "Building Neovim from source..."
    cd "$temp_dir"
    make CMAKE_BUILD_TYPE=RelWithDebInfo

    echo "Installing Neovim..."
    sudo make install

    cd - > /dev/null
    rm -rf "$temp_dir"

    if ! command -v nvim >/dev/null 2>&1; then
        echo "Error: Neovim installation failed or could not be added to PATH"
        return 1
    fi

    echo "Neovim successfully built and installed."
}

# Install Neovim using package manager
install_from_package_manager() {
    # Ubuntu/Debian
    if command -v apt-get >/dev/null 2>&1; then
        echo "Installing via apt..."
        sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt-get update
        sudo apt-get install -y neovim
    # Fedora
    elif command -v dnf >/dev/null 2>&1; then
        echo "Installing via dnf..."
        sudo dnf install -y neovim
    # Arch Linux
    elif command -v pacman >/dev/null 2>&1; then
        echo "Installing via pacman..."
        sudo pacman -S neovim
    # macOS
    elif command -v brew >/dev/null 2>&1; then
        echo "Installing via Homebrew..."
        brew install neovim
    else
        echo "Could not detect package manager. Please install Neovim manually."
        return 1
    fi

    if ! command -v nvim >/dev/null 2>&1; then
        echo "Error: Neovim installation failed or could not be added to PATH"
        return 1
    fi

    echo "Neovim successfully installed via package manager."
}

# Install Neovim configuration
install_config() {
    # Backup existing Neovim directories
    backup_directory "$NVIM_CONFIG_DIR"
    backup_directory "$NVIM_DATA_DIR"
    backup_directory "$NVIM_STATE_DIR"
    backup_directory "$NVIM_CACHE_DIR"

    echo "Cloning Neovim configuration..."

    # Clone configuration
    git clone https://github.com/S-Spektrum-M/mach-nvim "$NVIM_CONFIG_DIR"

    # Ask about removing .git
    read -p "Would you like to remove the .git folder? [Y/n] " choice_git
    if [[ -z "$choice_git" || "$choice_git" =~ ^[Yy] ]]; then
        echo "Removing .git folder..."
        rm -rf "$NVIM_CONFIG_DIR/.git"
    fi

    echo "Configuration successfully installed."
}

# Main execution
install_neovim
install_config

# First run initialization
echo -n "Would you like to run Neovim now to initialize plugins? [y/N] "
read -p "" choice_run
if [[ "$choice_run" =~ ^[Yy] ]]; then
    echo "Starting Neovim for the first time to install plugins..."
    nvim --headless "+Lazy sync" +qa
    echo "Plugins initialized. You can now use Neovim with your new configuration."
fi

echo "Setup complete! Your Neovim is ready to use."
