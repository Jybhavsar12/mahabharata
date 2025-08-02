#!/bin/bash

source ../mahabharata.sh

function honeypot_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║         ${RED}🍯 HONEYPOT ${CYAN}                  ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Start Honeypot${CYAN}                   ║"
    echo -e "║ ${YELLOW}2. View Captured Attacks${CYAN}            ║"
    echo -e "║ ${RED}0. Back to Main Menu${CYAN}                ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    read -p "Select an option [0-2]: " choice

    case $choice in
        1) start_honeypot ;;
        2) view_attacks ;;
        0) ../mahabharata.sh ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; honeypot_menu ;;
    esac
}

function start_honeypot {
    echo -e "${GREEN}[+] Starting Honeypot on port 2222...${NC}"
    echo -e "${YELLOW}Monitoring connections (Ctrl+C to stop)...${NC}"
    nc -l -k -p 2222 -v | tee -a logs/honeypot_$(date +%Y-%m-%d).log 2>&1
    honeypot_menu
}

function view_attacks {
    echo -e "${GREEN}[+] Recent Attack Attempts:${NC}"
    tail -n 20 logs/honeypot_*.log 2>/dev/null || echo -e "${RED}No attacks captured yet.${NC}"
    read -p "Press [Enter] to continue..."
    honeypot_menu
}

honeypot_menu
