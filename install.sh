#!/usr/bin/env bash

init() {
    # Vars
    CURRENT_USERNAME='CURRENT_USERNAME'  # Placeholder for replacement

    # Colors
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    BRIGHT=$(tput bold)
    UNDERLINE=$(tput smul)
}

confirm() {
    echo -en "[${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
}

print_header() {
    echo -E "$CYAN
     _     _             _     _  ___               _           
    | |   (_) __ _ _   _(_) __| |/ _ \ _ __  _ __  | | ___  ___ 
    | |   | |/ _\` | | | | |/ _\` | |_| | '_ \| '_ \| |/ _ \/ __|
    | |___| | (_| | |_| | | (_| |  _  | |_) | |_) | |  __/\__ \\\\
    |_____|_|\__, |\__,_|_|\__,_|_| |_| .__/| .__/|_|\___||___/
                |_|                  |_|   |_|                
     _   _ _       ___  ____     ____             __ _       
    | \ | (_)_  __/ _ \/ ___|   / ___|___  _ __  / _(_) __ _ 
    |  \| | \ \/ / | | \___ \  | |   / _ \| '_ \| |_| |/ _\` |
    | |\  | |>  <| |_| |___) | | |__| (_) | | | |  _| | (_| |
    |_| \_|_/_/\_\\\\___/|____/   \____\___/|_| |_|_| |_|\__, |
                                                       |___/ 

                  $BLUE https://github.com/LiquidApplesx/nixos $RED 
      ! To make sure everything runs correctly DONT run as root ! $GREEN
                        -> '"./install.sh"' $NORMAL

    "
}

get_username() {
    echo -en "Enter your$GREEN username$NORMAL : $YELLOW"
    read username
    echo -en "$NORMAL"
    echo -en "Use$YELLOW "$username"$NORMAL as ${GREEN}username${NORMAL} ? "
    confirm
}

set_username() {
    # Replace placeholder username in flake.nix
    sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./flake.nix
    
    # Replace in other files that might reference the username
    if [ -f "./modules/home/audacious.nix" ]; then
        sed -i -e "s/${CURRENT_USERNAME}/${username}/g" ./modules/home/audacious.nix
    fi
}

get_host() {
    echo -en "Choose a ${GREEN}host${NORMAL} - [${YELLOW}D${NORMAL}]esktop, [${YELLOW}L${NORMAL}]aptop or [${YELLOW}V${NORMAL}]irtual machine: "
    read -n 1 -r
    echo

    if [[ $REPLY =~ ^[Dd]$ ]]; then
        HOST='desktop'
    elif [[ $REPLY =~ ^[Ll]$ ]]; then
        HOST='laptop'
    elif [[ $REPLY =~ ^[Vv]$ ]]; then
        HOST='vm'
    else
        echo "Invalid choice. Please select 'D' for desktop, 'L' for laptop or 'V' for virtual machine."
        exit 1
    fi

    echo -en "$NORMAL"
    echo -en "Use the$YELLOW "$HOST"$NORMAL ${GREEN}host${NORMAL} ? "
    confirm
}

aseprite() {
    # whether to install aseprite or not
    echo -en "Disable ${GREEN}Aseprite${NORMAL} (faster install) ? [${GREEN}y${NORMAL}/${RED}n${NORMAL}]: "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return
    fi
    
    # Only disable if file exists
    if [ -f "modules/home/aseprite/aseprite.nix" ]; then
        sed -i '3s/  /  # /' modules/home/aseprite/aseprite.nix
    else
        echo "Aseprite module not found, skipping..."
    fi
}

install() {
    echo -e "\n${RED}START INSTALL PHASE${NORMAL}\n"

    # Create essential directories
    echo -e "Creating essential folders:"
    echo -e "    - ${MAGENTA}~/Music${NORMAL}"
    echo -e "    - ${MAGENTA}~/Documents${NORMAL}"
    echo -e "    - ${MAGENTA}~/Pictures/wallpapers/others${NORMAL}"
    mkdir -p ~/Music
    mkdir -p ~/Documents
    mkdir -p ~/Pictures/wallpapers/others

    # Copy the wallpapers if they exist
    if [ -f "wallpapers/wallpaper.png" ]; then
        echo -e "Copying main ${MAGENTA}wallpaper${NORMAL}"
        cp wallpapers/wallpaper.png ~/Pictures/wallpapers/
    fi
    
    if [ -d "wallpapers/otherWallpaper" ]; then
        echo -e "Copying additional ${MAGENTA}wallpapers${NORMAL}"
        cp -r wallpapers/otherWallpaper/gruvbox/* ~/Pictures/wallpapers/others/ 2>/dev/null || true
        cp -r wallpapers/otherWallpaper/nixos/* ~/Pictures/wallpapers/others/ 2>/dev/null || true
    fi

    # Get the hardware configuration
    echo -e "Copying ${MAGENTA}/etc/nixos/hardware-configuration.nix${NORMAL} to ${MAGENTA}./hosts/${HOST}/${NORMAL}\n"
    cp /etc/nixos/hardware-configuration.nix hosts/${HOST}/hardware-configuration.nix

    # Last Confirmation
    echo -en "You are about to start the system build, do you want to process ? "
    confirm

    # Build the system (flakes + home manager)
    echo -e "\nBuilding the system...\n"
    sudo nixos-rebuild switch --flake .#${HOST}
}

main() {
    init

    print_header

    get_username
    set_username
    get_host

    aseprite
    install
}

main && exit 0
