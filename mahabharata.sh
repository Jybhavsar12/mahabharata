#!/bin/bash

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# BANNER
function show_banner {
    clear
    echo -e "${RED}

    ███╗   ███╗ █████╗ ██╗  ██╗ █████╗ ██████╗ ██╗  ██╗ █████╗ ██████╗  █████╗ ████████╗ █████╗
    ████╗ ████║██╔══██╗██║  ██║██╔══██╗██╔══██╗██║  ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
    ██╔████╔██║███████║███████║███████║██████╔╝███████║███████║██████╔╝███████║   ██║   ███████║
    ██║╚██╔╝██║██╔══██║██╔══██║██╔══██║██╔══██╗██╔══██║██╔══██║██╔══██╗██╔══██║   ██║   ██╔══██║
    ██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██║██████╔╝██║  ██║██║  ██║██║  ██║██║  ██║   ██║   ██║  ██║
    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
    ${NC}${YELLOW}The Ultimate Cybersecurity Toolkit${NC}
    "
}

# MAIN MENU
function main_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║           ${RED}⚔️ M A H A B H A R A T A ${CYAN}      ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Network Analysis${CYAN}                   ║"
    echo -e "║ ${YELLOW}2. Vulnerability Scanner${CYAN}              ║"
    echo -e "║ ${YELLOW}3. Log Analyzer & Anomaly Detection${CYAN}   ║"
    echo -e "║ ${YELLOW}4. Incident Response Toolkit${CYAN}          ║"
    echo -e "║ ${YELLOW}5. Password Strength Auditor${CYAN}          ║"
    echo -e "║ ${YELLOW}6. Honeypot Monitor${CYAN}                   ║"
    echo -e "║ ${RED}0. Exit${CYAN}                               ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    echo ""
    read -p "Choose your weapon [0-6]: " choice

    case $choice in
        1) ./modules/network_analyzer.sh ;;
        2) ./modules/vulnerability_scanner.sh ;;
        3) ./modules/log_analyzer.sh ;;
        4) ./modules/incident_response.sh ;;
        5) ./modules/password_auditor.sh ;;
        6) ./modules/honeypot.sh ;;
        0) echo -e "${RED}Exiting Mahabharata...${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; main_menu ;;
    esac
}

# CHECK ROOT
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[!] This script must be run as root!${NC}"
    exit 1
fi

# CREATE DIRECTORIES IF NOT EXIST
mkdir -p modules logs

# START TOOL
main_menu
