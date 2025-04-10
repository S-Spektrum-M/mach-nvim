#!/usr/bin/env bash

# Exit on error, unset variable, and pipe failure
set -euo pipefail

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
NVIM_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
NVIM_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"
REQUIRED_NVIM_VERSION="0.9.0" # Set your minimum required version

# Default values for flags
INSTALL_METHOD=""
REMOVE_GIT=false
INSTALL_MACH_UPDATE=false
ADD_TO_PATH=false
INITIALIZE_PLUGINS=false
NON_INTERACTIVE=false

# Define color codes
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to display help
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Neovim Installation and Configuration Setup

Options:
    -h, --help                  Show this help message
    -n, --non-interactive       Run in non-interactive mode (requires other options to be set)
    -m, --method [SOURCE|PKG|SKIP]
                                Installation method:
                                  SOURCE = Build from source
                                  PKG = Use package manager
                                  SKIP = Skip Neovim installation
    -g, --git-keep              Keep .git directory (default is to remove it)
    -u, --update-tool           Install mach-update tool
    -p, --path                  Add mach-update to PATH
    -i, --init                  Initialize plugins after installation

Examples:
    # Interactive mode (default)
    $0

    # Non-interactive: Install from package manager, no git, install update tool, add to path, initialize plugins
    $0 -n -m PKG -u -p -i

    # Non-interactive: Skip Neovim installation, keep git, don't install update tool
    $0 -n -m SKIP -g
EOF
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -n|--non-interactive)
            NON_INTERACTIVE=true
            shift
            ;;
        -m|--method)
            if [[ -z "$2" || "$2" =~ ^- ]]; then
                echo "Error: --method requires an argument (SOURCE, PKG, or SKIP)"
                exit 1
            fi
            INSTALL_METHOD=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            shift 2
            ;;
        -g|--git-keep)
            REMOVE_GIT=false
            shift
            ;;
        -u|--update-tool)
            INSTALL_MACH_UPDATE=true
            shift
            ;;
        -p|--path)
            ADD_TO_PATH=true
            shift
            ;;
        -i|--init)
            INITIALIZE_PLUGINS=true
            shift
            ;;
        *)
     echo "Unknown option: $1"
            show_help
            ;;
    esac
done

# Validate non-interactive mode settings
if [[ "$NON_INTERACTIVE" == true ]]; then
    if [[ -z "$INSTALL_METHOD" ]]; then
        echo "Error: Non-interactive mode requires --method to be specified."
        exit 1
    fi

    if [[ "$INSTALL_METHOD" != "SOURCE" && "$INSTALL_METHOD" != "PKG" && "$INSTALL_METHOD" != "SKIP" ]]; then
        echo "Error: Invalid method '$INSTALL_METHOD'. Must be SOURCE, PKG, or SKIP."
        exit 1
    fi
fi

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

        if [[ "$NON_INTERACTIVE" == true ]]; then
            case "$INSTALL_METHOD" in
                "SOURCE")
                    install_from_source
                    ;;
                "PKG")
                    install_from_package_manager
                    ;;
                "SKIP")
                    echo "Skipping Neovim installation (as requested)."
                    ;;
                *)
                    echo "Invalid installation method: $INSTALL_METHOD"
                    exit 1
                    ;;
            esac
        else
            echo -e "${WHITE}Please select an installation method:${NC}"
            PS3=$'\033[1;37m> \033[0m'
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
        fi
    else
        echo "Neovim is already installed with a compatible version."
    fi
}

# Install Neovim from source
install_from_source() {
    echo "Installing build dependencies..."

    # Check if we're on Ubuntu/Debian
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl > /dev/null 2>&1
    # Check if we're on Fedora/RHEL/CentOS
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch curl > /dev/null 2>&1
    # Check if we're on Arch
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S base-devel cmake unzip ninja curl > /dev/null 2>&1
    # macOS with Homebrew
    elif command -v brew >/dev/null 2>&1; then
        brew install ninja libtool automake cmake pkg-config gettext curl > /dev/null 2>&1
    else
        echo "Could not detect package manager. Please install build dependencies manually."
        if [[ "$NON_INTERACTIVE" == false ]]; then
            echo -e "${WHITE}Continue anyway? [y/N]${NC} "
            read -p $'\033[1;37m> \033[0m' -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                return 1
            fi
        else
            echo "Continuing anyway in non-interactive mode."
        fi
    fi

    echo "Cloning Neovim repository..."
    local temp_dir=$(mktemp -d)
    git clone https://github.com/neovim/neovim.git "$temp_dir" --depth=1 --branch=stable > /dev/null 2>&1

    echo "Building Neovim from source (this may take a while)..."
    cd "$temp_dir"

    # Suppress make output but show a spinner to indicate progress
    echo -n "Building "
    make CMAKE_BUILD_TYPE=RelWithDebInfo > /dev/null 2>&1 &
    pid=$!
    spin='-\|/'
    i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\rBuilding %c " "${spin:$i:1}"
        sleep .1
    done
    printf "\rBuild complete!    \n"
    wait $pid || { echo "Build failed"; exit 1; }

    echo "Installing Neovim..."
    sudo make install > /dev/null 2>&1

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

    # Handle .git directory
    local remove_git=true

    if [[ "$NON_INTERACTIVE" == true ]]; then
        remove_git="$REMOVE_GIT"
    else
        echo -e "${WHITE}Would you like to remove the .git folder? [Y/n]${NC} "
        read -p $'\033[1;37m> \033[0m' choice_git
        [[ -z "$choice_git" || "$choice_git" =~ ^[Yy] ]] && remove_git=true || remove_git=false
    fi

    if [[ "$remove_git" == true ]]; then
        echo "Removing .git folder..."
        rm -rf "$NVIM_CONFIG_DIR/.git"
    else
        echo "Keeping .git folder for future updates."
    fi

    echo "Configuration successfully installed."
}

# Install mach-update to PATH
install_mach_update() {
    local install_update=false
    local add_to_path=false

    if [[ "$NON_INTERACTIVE" == true ]]; then
        install_update="$INSTALL_MACH_UPDATE"
        add_to_path="$ADD_TO_PATH"
    else
        echo -e "${WHITE}Would you like to install 'mach-update' to your PATH? [y/N]${NC} "
        read -p $'\033[1;37m> \033[0m' choice_mach
        [[ "$choice_mach" =~ ^[Yy] ]] && install_update=true
    fi

    if [[ "$install_update" == true ]]; then
        echo "Installing mach-update to PATH..."

        # Create the mach-update script in the right location
        MACH_UPDATE_SCRIPT="$NVIM_CONFIG_DIR/bin/mach-update"

        # Ensure the bin directory exists
        mkdir -p "$NVIM_CONFIG_DIR/bin"

        # Create the mach-update script
        cat > "$MACH_UPDATE_SCRIPT" << 'EOF'
#!/usr/bin/env bash

# Script to update mach-nvim configuration
set -euo pipefail

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

echo "=== Updating mach-nvim ==="

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo "Error: Neovim configuration directory not found at $NVIM_CONFIG_DIR"
    exit 1
fi

# Check if .git directory exists
if [ ! -d "$NVIM_CONFIG_DIR/.git" ]; then
    echo "Warning: .git directory not found. Your configuration may have been installed without git history."
    echo "Manual update required. Please reinstall the configuration."
    exit 1
fi

# Update the configuration
echo "Pulling latest changes..."
cd "$NVIM_CONFIG_DIR"
git pull

# Update plugins
echo "Updating plugins..."
echo -n "Syncing "
nvim --headless "+Lazy sync" +qa > /dev/null 2>&1 &
pid=$!
spin='-\|/'
i=0
while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) % 4 ))
    printf "\rSyncing %c " "${spin:$i:1}"
    sleep .1
done
printf "\rSync complete!    \n"
wait $pid || { echo "Plugin sync failed"; exit 1; }

echo "mach-nvim has been updated successfully!"
EOF

        # Make it executable
        chmod +x "$MACH_UPDATE_SCRIPT"

        # Set up symbolic link to make it available in PATH
        LOCAL_BIN_DIR="$HOME/.local/bin"
        mkdir -p "$LOCAL_BIN_DIR"

        # Create symlink
        ln -sf "$MACH_UPDATE_SCRIPT" "$LOCAL_BIN_DIR/mach-update"

        # Check if ~/.local/bin is in PATH, if not suggest adding it
        if [[ ":$PATH:" != *":$LOCAL_BIN_DIR:"* ]]; then
            echo "Notice: $LOCAL_BIN_DIR is not in your PATH."

            if [[ "$NON_INTERACTIVE" == true ]]; then
                if [[ "$ADD_TO_PATH" == true ]]; then
                    add_to_path=true
                fi
            else
                echo "To add it, run:"
                echo "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
                echo "  source ~/.bashrc"

                # Ask if user wants to add it automatically
                echo -e "${WHITE}Would you like to add it automatically? [y/N]${NC} "
                read -p $'\033[1;37m> \033[0m' choice_path
                [[ "$choice_path" =~ ^[Yy] ]] && add_to_path=true
            fi

            if [[ "$add_to_path" == true ]]; then
                SHELL_RC=""
                if [[ "$SHELL" == *"zsh"* ]]; then
                    SHELL_RC="$HOME/.zshrc"
                elif [[ "$SHELL" == *"bash"* ]]; then
                    SHELL_RC="$HOME/.bashrc"
     fi

                if [[ -n "$SHELL_RC" ]]; then
                    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
                    echo "Added $LOCAL_BIN_DIR to your PATH in $SHELL_RC"
                    echo "Please restart your terminal or run 'source $SHELL_RC' for the changes to take effect."
                else
                    echo "Could not detect shell configuration file. Please add $LOCAL_BIN_DIR to your PATH manually."
                fi
            fi
        else
            echo "mach-update has been successfully installed to your PATH."
            echo "You can now run 'mach-update' from anywhere to update your mach-nvim configuration."
        fi
    else
        echo "Skipping mach-update installation."
    fi
}

# Function to initialize plugins with suppressed output
initialize_plugins() {
    echo "Initializing plugins (this may take a moment)..."
    echo -n "Syncing "
    nvim --headless "+Lazy sync" +qa > /dev/null 2>&1 &
    pid=$!
    spin='-\|/'
    i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\rSyncing %c " "${spin:$i:1}"
        sleep .1
    done
    printf "\rSync complete!    \n"
    wait $pid || { echo "Plugin initialization failed"; return 1; }
    echo "Plugins initialized successfully."
}

# Main execution
install_neovim
install_config
install_mach_update

# First run initialization
if [[ "$NON_INTERACTIVE" == true ]]; then
    if [[ "$INITIALIZE_PLUGINS" == true ]]; then
        initialize_plugins
        echo "Plugins initialized. You can now use Neovim with your new configuration."
    fi
else
    echo -e "${WHITE}Would you like to run Neovim now to initialize plugins? [y/N]${NC} "
    read -p $'\033[1;37m> \033[0m' choice_run
    if [[ "$choice_run" =~ ^[Yy] ]]; then
        initialize_plugins
        echo "You can now use Neovim with your new configuration."
    fi
fi

echo "Setup complete! Your Neovim is ready to use."
