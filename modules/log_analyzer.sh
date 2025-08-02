#!/bin/bash

source ../mahabharata.sh

function log_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║       ${RED}🔍 LOG ANALYZER ${CYAN}                 ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Auth Log Analysis${CYAN}                ║"
    echo -e "║ ${YELLOW}2. Failed Login Attempts${CYAN}            ║"
    echo -e "║ ${YELLOW}3. SSH Attack Detection${CYAN}             ║"
    echo -e "║ ${RED}0. Back to Main Menu${CYAN}                ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    read -p "Select an option [0-3]: " choice

    case $choice in
        1) auth_logs ;;
        2) failed_logins ;;
        3) ssh_attacks ;;
        0) ../mahabharata.sh ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; log_menu ;;
    esac
}

function auth_logs {
    echo -e "${GREEN}[+] Analyzing /var/log/auth.log...${NC}"
    grep -i 'failed' /var/log/auth.log | tail -n 20 | tee logs/auth_analysis_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    log_menu
}

function failed_logins {
    echo -e "${GREEN}[+] Checking Failed Login Attempts...${NC}"
    lastb | head -n 20 | tee logs/failed_logins_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    log_menu
}

function ssh_attacks {
    echo -e "${GREEN}[+] Detecting SSH Attacks...${NC}"
    echo -e "${YELLOW}Top 10 IPs with failed SSH attempts:${NC}"
    grep -i 'sshd.*fail' /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | head -n 10 | tee logs/ssh_attacks_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    log_menu
}

log_menu
