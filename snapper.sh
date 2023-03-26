#!/bin/bash

YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'

clear
banner (){
	echo ""
	echo -e "${BLUE}███████╗███╗   ██╗ █████╗ ██████╗ ██████╗ ███████╗██████╗"
	echo -e "${BLUE}██╔════╝████╗  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
	echo -e "${BLUE}███████╗██╔██╗ ██║███████║██████╔╝██████╔╝█████╗  ██████╔╝"
	echo -e "${BLUE}╚════██║██║╚██╗██║██╔══██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗"
	echo -e "${BLUE}███████║██║ ╚████║██║  ██║██║     ██║     ███████╗██║  ██║"
	echo -e "${BLUE}╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝"
	echo ""
	echo -e "${YELLOW}[${BLUE}!!!${YELLOW}] ${BLUE}Tool-Name ${YELLOW}: ${GREEN}Snapper"
	echo -e "${YELLOW}[${BLUE}!!!${YELLOW}] ${BLUE}Github    ${YELLOW}: ${GREEN}https://github.com/K3ysTr0K3R"
	echo -e "${YELLOW}[${BLUE}!!!${YELLOW}] ${BLUE}Instagram ${YELLOW}: ${GREEN}1_k3ystr0k3r_1"
	echo -e "${YELLOW}[${BLUE}!!!${YELLOW}] ${BLUE}Coded By  ${YELLOW}: ${GREEN}K3ysTr0K3R"
	echo ""
}
banner
echo -ne "${YELLOW}[${GREEN}!${YELLOW}] Enter any username you want${BLUE}:${RED} "
read username
clear
if [ -z "$username" ]; then
	banner
	echo -e "${YELLOW}[${GREEN}!!!${YELLOW}] You didnt enter a username"
	exit 1
fi

banner
echo -e "${YELLOW}[${GREEN}!${YELLOW}] Looking for ${RED}$username ${YELLOW}on Snapchat"
curl -o /dev/null --silent --head --write-out '%{http_code}\n' https://www.snapchat.com/add/$username | grep "200" &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "${YELLOW}[${BLUE}+${YELLOW}] Username Found on Snapchat${BLUE}:${RED} $username"
else
	echo -e "${YELLOW}[${RED}~${YELLOW}] No username with that name exists on Snapchat"
	exit 1
fi

echo -e "${YELLOW}[${BLUE}+${YELLOW}] Fetching $username Image"
wget https://story.snapchat.com/@$username/preview/square.jpeg &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "${YELLOW}[${BLUE}+${YELLOW}] Found Image On ${RED}$username"
else
	echo -e "${YELLOW}[${RED}~${YELLOW}] Image not Found"
	exit 1
fi

echo -e "${YELLOW}[${BLUE}+${YELLOW}] Fetching ${RED}$username ${YELLOW}QRcode"
wget "https://feelinsonice.appspot.com/web/deeplink/snapcode?username=$username&size=400&type=SVG" &> /dev/null
if [ $? -eq 0 ]; then
	echo -e "${YELLOW}[${BLUE}+${YELLOW}] Found QRcode${BLUE}:${GREEN} https://feelinsonice.appspot.com/web/deeplink/snapcode?username=${RED}$username${GREEN}&size=400&type=SVG"
else
	echo -e "${YELLOW}[${RED}~${YELLOW}] QRcode not Found"
	exit 1
fi

echo -ne "${YELLOW}[${GREEN}!${YELLOW}] Would you like to open the Image on ${RED}$username${YELLOW}? ${YELLOW}[${GREEN}y${YELLOW}/${RED}n${YELLOW}]${RED} "
read YES_NO
if [ "$YES_NO" == "y" ]; then
	echo -e "${YELLOW}[${BLUE}+${YELLOW}] Opening Image From ${RED}$username"
	open square.jpeg &> /dev/null
	sleep 10
	rm square.jpeg
        rm "snapcode?username=$username&size=400&type=SVG"
	echo -e "${YELLOW}[${GREEN}!${YELLOW}] Thank you for using Snapper"
else
	rm square.jpeg
        rm "snapcode?username=$username&size=400&type=SVG"
	echo -e "${YELLOW}[${GREEN}!${YELLOW}] Thank you for using Snapper"
fi
