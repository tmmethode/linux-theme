#!/bin/bash

# Function to install configurations
install_configs() {
    sudo apt install unzip -y
    unzip -o tm_setup.zip -d ~/.config
    cd ~/.local/share && zip -r ~/.config/tm_setup/gnome-shell.zip gnome-shell/
    cd ~/.config/tm_setup
    dconf dump / > backup.dconf

    sudo apt install gnome-tweaks -y
    sudo apt install chrome-gnome-shell -y
    ./WhiteSur-gtk-theme/install.sh -t red
    ./Reversal-icon-theme-master/install.sh -red
    unzip fonts.zip -d ~/.local/share/
    ./Vimix-cursors/install.sh
    mkdir ~/.icons
    mv ~/.local/share/icons/Vimix-cursors/ ~/.icons/
    mv ~/.local/share/icons/Vimix-white-cursors/ ~/.icons/
        # Get GNOME Shell version

    gnome_shell_version=$(gnome-shell --version | awk '{print $3}')
    major_version=${gnome_shell_version%%.*}

    # Check major version and execute corresponding file

    if [[ $major_version -eq 40 ]]; then
    echo "Detected GNOME Shell 40. Executing gnome40.zip"
    unzip -o gnome40.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 41 ]]; then
    echo "Detected GNOME Shell 41. Executing gnome41.zip"
    unzip -o gnome41.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 42 ]]; then
    echo "Detected GNOME Shell 42. Executing gnome42.zip"
    unzip -o gnome42.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 43 ]]; then
    echo "Detected GNOME Shell 43. Executing gnome43.zip"
    unzip -o gnome43.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 44 ]]; then
    echo "Detected GNOME Shell 44. Executing gnome44.zip"
    unzip -o gnome44.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 45 ]]; then
    echo "Detected GNOME Shell 45. Executing gnome45.zip"
    unzip -o gnome45.zip -d ~/.local/share/gnome-shell/
    elif [[ $major_version -eq 46 ]]; then
    echo "Detected GNOME Shell 46. Executing gnome46.zip"
    unzip -o gnome46.zip -d ~/.local/share/gnome-shell/
    else
    echo "Unsupported GNOME Shell version: $major_version"
    fi
    sudo cp Milkyway.png /usr/local/share/
    dconf load / < gnome_tweaks.dconf
    echo "Logging out......"
    sleep 5  # Wait for 5 seconds
    gnome-session-quit --logout --no-prompt
}

# Function to uninstall configurations
uninstall_configs() {
    cd ~/.config/tm_setup/
    rm -rf ~/.local/share/fonts
    rm -rf ~/.local/share/gnome-shell/
    unzip -o gnome-shell.zip -d ~/.local/share/
    dconf reset -f /org/gnome/
    dconf load / < backup.dconf 
    rm -rf ~/.config/tm_setup/ 
    echo "Logging out......"
    sleep 5  # Wait for 5 seconds
    gnome-session-quit --logout --no-prompt
}

# Main script
echo "Welcome to setup script!"
echo "Choose an option:"
echo "1. Install configurations"
echo "2. Uninstall configurations"

echo -n "Choice: "
read choice

gnome_shell_minor_version=$(gnome-shell --version | awk '{printf "%.2f\n", $3}')
gnome_shell_version=$(gnome-shell --version | awk '{print $3}')
major_version=${gnome_shell_version%%.*}
case "$choice" in
    1)
        if [[ $major_version -eq 40 || $major_version -eq 41 || $major_version -eq 42 || $major_version -eq 43 || $major_version -eq 44 || $major_version -eq 45 || $major_version -eq 46 ]]; then
        # Handle versions 40, 41, and 42, .. as a group
        echo "Detected a supported GNOME Shell version $major_version" 
            echo "Executing setup.sh"
            sleep 5  # Wait for 5 seconds
            # Check if tm_setup.zip exists, if not, download it
                if [ -d ~/.config/tm_setup ]; then
                echo "Setup Already installed!"
                echo "Terminating..."
                sleep 3
                exit 1

                elif [ ! -f "tm_setup.zip" ]; then
                    echo "Downloading setup..."
                    wget  https://example.com/tm_setup.zip
                fi
                # Check again if tm_setup.zip exists
                if [ -f "tm_setup.zip" ]; then
                    install_configs
                else
                    echo "Failed to download setup. Exiting."
                fi

        else 
                echo "Unsupported GNOME Shell version $major_version.  Terminating..."
                sleep 3
                fi
                ;;
    2)
                    # Check again if folder exists
        if [ -d ~/.config/tm_setup ]; then
                echo "Uninstalling....."
                sleep 4
                uninstall_configs
        else
                echo "Not exist in your system!. Exiting."
                sleep 3
        fi
        ;;
    *)
        echo "Invalid choice. Please type '1' for installation or '2' for uninstallation."
        ;;
esac



