#!/bin/bash

# Colors and visual settings
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)
WIDTH=50

# Header
header() {
    clear
    echo "${BLUE}${BOLD}╔═════════════════════════════════════╗"
    echo "║${WHITE}  ANDROID WIFI DEBUGGING CONNECTION  ${BLUE}║"
    echo "╚═════════════════════════════════════╝${RESET}"
    echo
}

# Error messages
error() {
    echo "${RED}${BOLD}⨯ ERROR: $1${RESET}"
    echo
    exit 1
}

# Draws a divider line
divider_line() {
    echo "${CYAN}──────────────────────────────────────────────────${RESET}"
}

# Check platform-tools
PLATFORM_TOOLS="$HOME/Android/Sdk/platform-tools"
header
if [ ! -d "$PLATFORM_TOOLS" ]; then
    error "platform-tools directory not found at:
    $PLATFORM_TOOLS
Please check your Android SDK installation."
fi

# Collecting information
header
echo "${BOLD}${GREEN}►► Enter the device details:${RESET}"
divider_line
echo -n "${BOLD}${YELLOW}► IP Address: ${RESET}"
read -r IP
echo -n "${BOLD}${YELLOW}► Port: ${RESET}"
read -r PORT

# Input validation
if [ -z "$IP" ] || [ -z "$PORT" ]; then
    header
    error "IP and port are required!"
fi

# Pairing process
header
echo "${BOLD}${GREEN}►► Starting pairing with ${WHITE}$IP:$PORT${RESET}"
divider_line
echo "${YELLOW}› Waiting for pairing code..."
echo "› The code will appear on the Android device"
echo "› Be ready to type it when prompted${RESET}"
divider_line

cd "$PLATFORM_TOOLS" || error "Unable to access the directory!"

# Run the pairing command
if ! ./adb pair "$IP:$PORT"; then
    error "Pairing failed! Please check the data and connection."
fi

# Finalization
header
echo "${GREEN}${BOLD}✔ Pairing successful!${RESET}"
divider_line
echo "${BOLD}Press ENTER to finish...${RESET}"
read -r

header
echo "${GREEN}${BOLD}Script completed!${RESET}"
echo
