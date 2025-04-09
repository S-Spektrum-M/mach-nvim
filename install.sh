set -e

if ! command -v nvim >/dev/null 2>&1
then
    read -p "Neovim could not be found on path. Would you like to build from source [y/n] " choice_build
    if [ "$choice_build" = "y" ]
    then
        git clone git@github.com:neovim/neovim.git --depth=1 --no-single-branch
        cd neovim
        git checkout stable
        make CMAKE_BUILD_TYPE=RelWithDebInfo
        sudo make install
        if ! command -v nvim 2>&1 >/dev/null
        then
            echo "Neovim could not be added to PATH"
            exit 1
        fi
    fi
fi

mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone https://github.com/S-Spektrum-M/mach-nvim ~/.config/nvim

read -p "Would you like to remove the .git folder? [y/n] " choice_git

if [ "$choice_git" = "y" ]
then
    rm -rf ~/.config/nvim/.git
fi
