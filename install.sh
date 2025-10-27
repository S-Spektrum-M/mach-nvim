#!/usr/bin/env bash

# Exit on error, unset variable, and pipe failure
set -euo pipefail

# --- Configuration ---
REQUIRED_NVIM_VERSION="0.9.0"

# --- Colors ---
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# --- Functions ---

# Log a message
log() {
    echo -e "${WHITE}==>${NC} $1"
}

# Function to check Neovim version
check_nvim_version() {
    # 1. Check if nvim command exists
    if ! command -v nvim &>/dev/null; then
        log "Neovim is not installed."
        return 1 # Not installed
    fi

    # 2. Get the installed version string (e.g., "0.9.5")
    local version
    version=$(nvim --version | head -n1 | cut -d ' ' -f2 | sed 's/v//')

    # 3. Compare with the required version
    if [ "$(printf '%s\n' "$REQUIRED_NVIM_VERSION" "$version" | sort -V | head -n1)" != "$REQUIRED_NVIM_VERSION" ]; then
        log "Installed Neovim version ($version) is older than required ($REQUIRED_NVIM_VERSION)."
        return 1 # Version too old
    fi

    log "Installed Neovim version ($version) meets the requirements."
    return 0 # Success
}

# Function to install Neovim from source (RHEL-specific)
install_neovim_from_source() {
    log "Installing build dependencies for RHEL..."

    # Define RHEL build dependencies
    # git is needed for cloning nvim and the config
    local rhel_packages="git ninja-build gettext libtool autoconf automake cmake gcc-c++ pkg-config unzip patch make"

    # 1. Detect package manager and install dependencies
    if command -v dnf &>/dev/null; then
        # RHEL 8/9
        log "Detected dnf (RHEL 8/9). Enabling CRB/PowerTools repo..."
        # RHEL 8 uses 'powertools', RHEL 9 uses 'crb'. Try both, ignore errors.
        sudo dnf config-manager --set-enabled powertools > /dev/null 2>&1 || true
        sudo dnf config-manager --set-enabled crb > /dev/null 2>&1 || true

        log "Installing dependencies via dnf..."
        sudo dnf install -y $rhel_packages > /dev/null
    elif command -v yum &>/dev/null; then
        # RHEL 7
        log "Detected yum (RHEL 7). Enabling EPEL repo..."
        sudo yum install -y epel-release > /dev/null

        log "Installing dependencies via yum..."
        sudo yum install -y $rhel_packages > /dev/null
    else
        echo "Could not detect 'dnf' or 'yum'. This script is intended for RHEL."
        echo "Please install build dependencies manually: $rhel_packages"
        return 1
    fi
    log "Build dependencies installed."

    log "Cloning Neovim repository..."
    local temp_dir
    temp_dir=$(mktemp -d)
    git clone https://github.com/neovim/neovim.git "$temp_dir" --depth=1 --branch=stable > /dev/null 2>&1

    log "Building Neovim from source (this may take a while)..."
    cd "$temp_dir"
    make CMAKE_BUILD_TYPE=RelWithDebInfo > /dev/null 2>&1
    sudo make install > /dev/null 2>&1

    cd - >/dev/null
    rm -rf "$temp_dir"
    log "Neovim has been built and installed successfully."
}

# Main logic to orchestrate the installation
install_neovim() {
    if check_nvim_version; then
        # If version is okay, do nothing.
        return 0
    fi

    # Check if the "-y" flag is provided, then auto install without prompting.
    for arg in "$@"; do
        if [ "$arg" = "-y" ]; then
            install_neovim_from_source
            return $?
        fi
    done

    # If check fails, ask the user if they want to build from source.
    echo -e "${WHITE}Do you want to build and install the latest stable Neovim from source? [Y/n]${NC} "
    read REPLY
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then
        install_neovim_from_source
    else
        log "Skipping Neovim installation. Your Neovim setup might not work as expected."
        exit 1
    fi
}

# Backup existing nvim config and symlink the new one
install_config() {
    local nvim_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
    local backup_dir="${nvim_config_dir}.$(date +%Y%m%d%H%M%S).bak"
    # Note: This script assumes the config repo is being cloned,
    # not symlinked from where the script is.
    # local source_dir="$(cd "$(dirname "$0")" && pwd)"

    if [ -L "$nvim_config_dir" ]; then
        log "Removing existing symlink: $nvim_config_dir"
        rm "$nvim_config_dir"
    elif [ -d "$nvim_config_dir" ]; then
        log "Backing up existing nvim config to $backup_dir"
        mv "$nvim_config_dir" "$backup_dir"
    fi

    log "Installing config to $nvim_config_dir"
    git clone https://github.com/S-Spektrum-M/mach-nvim $nvim_config_dir
    log "Configuration installed successfully."
    # log "Symlinking $source_dir to $nvim_config_dir"
    # ln -s "$source_dir" "$nvim_config_dir"
}

# Initialize plugins and install LSPs
initialize_plugins_and_lsps() {
    log "Initializing plugins..."
    # This command syncs plugins with your configuration (e.g., using Lazy.nvim)
    nvim --headless "+Lazy! sync" +qa

    # Embedded LSP install list
    read -r -d '' embedded_lsps <<'EOF'
bash-language-server
clangd
deno
gopls
json-lsp
lua-language-server
neocmakelsp
python-lsp-server
rust-analyzer
taplo
texlab
yaml-language-server
zls
EOF


    local lsps_to_install
    lsps_to_install=$(echo "$embedded_lsps" | tr '\n' ' ')

    # Check if there are any LSPs left to install after filtering
    if [ -z "$lsps_to_install" ]; then
        log "No LSPs to install. Skipping LSP installation."
        return
    fi

    log "Installing LSPs: $lsps_to_install"
    # Use Mason to install the LSPs
    nvim --headless "+MasonInstall $lsps_to_install" +qa
    log "Plugin and LSP installation complete.\n"
}

# --- Main Execution ---
main() {
    # Ensure ~/.config exists before trying to install config
    mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"

    install_neovim "$@"
    install_config
    initialize_plugins_and_lsps

    log "All done. Enjoy your new Neovim setup!"
}

main "$@"
