#!/bin/bash

# COLORS
source ../mahabharata.sh

function network_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║          ${RED}⚡ NETWORK ANALYSIS ${CYAN}           ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Port Scanner${CYAN}                     ║"
    echo -e "║ ${YELLOW}2. Live Traffic Monitor${CYAN}             ║"
    echo -e "║ ${YELLOW}3. Detect Open Connections${CYAN}           ║"
    echo -e "║ ${YELLOW}4. Packet Sniffer (Basic)${CYAN}           ║"
    echo -e "║ ${RED}0. Back to Main Menu${CYAN}                ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    echo ""
    read -p "Select an option [0-4]: " choice

    case $choice in
        1) port_scanner ;;
        2) traffic_monitor ;;
        3) open_connections ;;
        4) packet_sniffer ;;
        0) ../mahabharata.sh ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; network_menu ;;
    esac
}

function port_scanner {
    echo -e "${GREEN}[+] Running Port Scanner...${NC}"
    read -p "Enter target IP or domain: " target
    nmap -sV $target | tee logs/port_scan_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    network_menu
}

function traffic_monitor {
    echo -e "${GREEN}[+] Monitoring Network Traffic...${NC}"
    ifconfig | grep -E 'eth|wlan'
    read -p "Enter interface (e.g., eth0): " interface
    sudo tcpdump -i $interface | tee logs/traffic_$(date +%Y-%m-%d).log
    network_menu
}

function open_connections {
    echo -e "${GREEN}[+] Checking Active Connections...${NC}"
    netstat -tulnp | tee logs/connections_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    network_menu
}

function packet_sniffer {
    echo -e "${GREEN}[+] Starting Basic Packet Sniffer...${NC}"
    sudo tcpdump -i any -c 50 -w logs/packets_$(date +%Y-%m-%d).pcap
    echo -e "${YELLOW}[!] Saved to logs/packets_$(date +%Y-%m-%d).pcap${NC}"
    read -p "Press [Enter] to continue..."
    network_menu
}

network_menu
