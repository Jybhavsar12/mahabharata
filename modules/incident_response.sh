#!/bin/bash

source ../mahabharata.sh

function ir_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║       ${RED}🛡️ INCIDENT RESPONSE ${CYAN}           ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Collect System Evidence${CYAN}          ║"
    echo -e "║ ${YELLOW}2. Analyze Running Processes${CYAN}        ║"
    echo -e "║ ${YELLOW}3. Check for Rootkits${CYAN}               ║"
    echo -e "║ ${RED}0. Back to Main Menu${CYAN}                ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    read -p "Select an option [0-3]: " choice

    case $choice in
        1) collect_evidence ;;
        2) analyze_processes ;;
        3) rootkit_check ;;
        0) ../mahabharata.sh ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; ir_menu ;;
    esac
}

function collect_evidence {
    echo -e "${GREEN}[+] Collecting System Evidence...${NC}"
    mkdir -p logs/forensics_$(date +%Y-%m-%d)
    uname -a > logs/forensics_$(date +%Y-%m-%d)/system_info.txt
    lscpu > logs/forensics_$(date +%Y-%m-%d)/cpu_info.txt
    lsblk > logs/forensics_$(date +%Y-%m-%d)/disk_info.txt
    netstat -tulnp > logs/forensics_$(date +%Y-%m-%d)/network_connections.txt
    ps aux > logs/forensics_$(date +%Y-%m-%d)/process_list.txt
    echo -e "${GREEN}Evidence collected in logs/forensics_$(date +%Y-%m-%d)/${NC}"
    read -p "Press [Enter] to continue..."
    ir_menu
}

function analyze_processes {
    echo -e "${GREEN}[+] Analyzing Running Processes...${NC}"
    ps aux --sort=-%cpu | head -n 10 | tee logs/process_analysis_$(date +%Y-%m-%d).log
    echo -e "\n${YELLOW}Checking for suspicious processes...${NC}"
    ps aux | grep -E '(nc|netcat|telnet|nmap|perl|python|ruby|bash|sh)' | tee -a logs/process_analysis_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    ir_menu
}

function rootkit_check {
    echo -e "${GREEN}[+] Checking for Rootkits...${NC}"
    if ! command -v rkhunter &> /dev/null; then
        echo -e "${RED}rkhunter not found! Install with 'sudo apt install rkhunter'${NC}"
    else
        rkhunter --check --sk | tee logs/rootkit_scan_$(date +%Y-%m-%d).log
    fi
    read -p "Press [Enter] to continue..."
    ir_menu
}

ir_menu
