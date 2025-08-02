#!/bin/bash

source ../mahabharata.sh

function password_menu {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════╗"
    echo -e "║       ${RED}🔑 PASSWORD AUDITOR ${CYAN}             ║"
    echo -e "╠══════════════════════════════════════╣"
    echo -e "║ ${YELLOW}1. Password Policy Check${CYAN}            ║"
    echo -e "║ ${YELLOW}2. Crack Password Hashes${CYAN}            ║"
    echo -e "║ ${YELLOW}3. Generate Strong Passwords${CYAN}        ║"
    echo -e "║ ${RED}0. Back to Main Menu${CYAN}                ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    read -p "Select an option [0-3]: " choice

    case $choice in
        1) policy_check ;;
        2) crack_hashes ;;
        3) generate_passwords ;;
        0) ../mahabharata.sh ;;
        *) echo -e "${RED}Invalid choice!${NC}"; sleep 1; password_menu ;;
    esac
}

function policy_check {
    echo -e "${GREEN}[+] Checking Password Policies...${NC}"
    grep -E 'PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE' /etc/login.defs | tee logs/password_policy_$(date +%Y-%m-%d).log
    echo -e "\n${YELLOW}Checking for empty passwords:${NC}"
    awk -F: '($2 == "") {print $1}' /etc/shadow | tee -a logs/password_policy_$(date +%Y-%m-%d).log
    read -p "Press [Enter] to continue..."
    password_menu
}

function crack_hashes {
    echo -e "${GREEN}[+] Password Hash Cracking${NC}"
    read -p "Enter hash to crack: " hash
    read -p "Enter wordlist path (default: /usr/share/wordlists/rockyou.txt): " wordlist
    wordlist=${wordlist:-/usr/share/wordlists/rockyou.txt}
    if ! command -v john &> /dev/null; then
        echo -e "${RED}John the Ripper not found! Install with 'sudo apt install john'${NC}"
    else
        echo $hash > logs/hash_to_crack.txt
        john --wordlist=$wordlist logs/hash_to_crack.txt | tee logs/hash_cracking_$(date +%Y-%m-%d).log
    fi
    read -p "Press [Enter] to continue..."
    password_menu
}

function generate_passwords {
    echo -e "${GREEN}[+] Generating Strong Passwords...${NC}"
    echo -e "${YELLOW}5 Strong Password Suggestions:${NC}"
    for i in {1..5}; do
        openssl rand -base64 12 | cut -c1-16 | tee -a logs/password_generator_$(date +%Y-%m-%d).log
    done
    read -p "Press [Enter] to continue..."
    password_menu
}

password_menu
