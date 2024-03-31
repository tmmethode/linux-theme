#!/bin/bash

# Function to install configurations
install_configs() {
 
    sudo apt install gnome-tweaks -y
    sudo apt install chrome-gnome-shell -y
    unzip -o tm_setup.zip -d ~/.config
    cd ~/.config/tm_setup
    ./WhiteSur-gtk-theme/install.sh -t red
    ./Reversal-icon-theme-master/install.sh -red
    sudo apt install unzip -y
    dconf dump / > backup.dconf
    mv ~/.local/share/gnome-shell/backup.dconf .
    unzip fonts.zip -d ~/.local/share/
    ./Vimix-cursors/install.sh
    mkdir ~/.icons
    mv ~/.local/share/icons/Vimix-cursors/ ~/.icons/
    mv ~/.local/share/icons/Vimix-white-cursors/ ~/.icons/
    unzip -o extensions.zip -d ~/.local/share/gnome-shell/
    cp Milkyway.png ~/.local/share/gnome-shell
    dconf load /org/gnome/shell/extensions/ < tm.conf
    dconf load / < gnome_tweaks.dconf
    gnome-session-quit --logout --no-prompt
}

# Function to uninstall configurations
uninstall_configs() {
    dconf load / < ~/.local/share/gnome-shell/backup.dconf
    rm ~/.local/share/gnome-shell/backup.dconf
    sudo apt remove gnome-tweaks -y
    sudo apt remove chrome-gnome-shell -y
    rm -rf ~/.local/share/fonts
    rm -rf ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com
    rm -rf ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx
    rm -rf ~/.local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com
    rm -rf ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com
    rm -rf ~/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io
    rm -rf ~/.local/share/gnome-shell/extensions/mediacontrols@cliffniff.github.com
    rm -rf ~/.local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com 
    gnome-session-quit --logout --no-prompt
}

# Main script
echo "Welcome to setup script!"
echo "Choose an option:"
echo "1. Install configurations"
echo "2. Uninstall configurations"
read choice

case "$choice" in
    1)
       # Check if tm_setup.zip exists, if not, download it
        if [ ! -f "tm_setup.zip" ]; then
            echo "Downloading setup..."
            wget https://raw.githubusercontent.com/tmmethode/linux-theme/main/tm_setup.zip
        fi
        # Check again if tm_setup.zip exists
        if [ -f "tm_setup.zip" ]; then
            install_configs
        else
            echo "Failed to download setup. Exiting."
        fi
        ;;
    2)
        uninstall_configs
        ;;
    *)
        echo "Invalid choice. Please type '1' for installation or '2' for uninstallation."
        ;;
esac
