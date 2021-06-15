#! /bin/bash

# Sascha Scheidegger, Jacob Boesen
# CI 201

# This script aims to provide services for various networking activities such as ping sweeps, port scans, and displaying scan results.

MainMenu() {
	echo -e "\n------- Main Menu -------"
	select choice in "Ping Sweep" "Port Scan" "Print Scan Results" "Exit Program"
	do
		case $choice in
			"Ping Sweep" )
				PingSweep
				;;
			"Port Scan" )
				PortScan
				;;
			"Print Scan Results" )
				PrintScanResults
				;;
			"Exit Program" )
				echo "Exiting the program"
				exit 0
				;;
			* )
				echo "Invalid selection."
				MainMenu
				;;
		esac
	done
}

PingSweep() {
	echo -e "\n------- Ping Sweep -------"
	date >> pingresults.txt
	while read -t 0.01; do :; done
	read -p "Enter the first 3 IP numbers as shown on the address (eg. 192.168.10): " ip
	for i in $ip.{1..255}
	do
		echo "Pinging $i..."
		if [ `ping -c 1 $i | grep bytes | wc -l` -gt 1 ]
		then
			echo "$i is up" >> pingresults.txt
		fi
	done
	MainMenu
}

PortScan() {
	echo -e "\n------- Port Scan -------"
	date >> portscanresults.txt
	while read -t 0.01; do :; done
	read -p "Enter the IP address of the host you wish to scan, as shown exactly: " ip
	echo "Scanning ports for $ip"
	for i in {1..65535}
	do
		if [ `nc -w 1 -z -v $ip $i 2>&1 | grep succeeded | wc -l` -ge 1 ]
		then
			echo "Port $i for $ip is open" >> portscanresults.txt
		fi		
	done
	MainMenu
}

PrintScanResults() {
	echo -e "\n------- Print Scan Results Menu -------"
	select choice in "Display Ping Sweep Results" "Display Port Scan Results" "Remove Ping Sweep Results File" "Remove Port Scan Results File" "Return to Main Menu"
	do
		case $choice in
			"Display Ping Sweep Results" )
				echo -e "\n--- Ping Sweep Results ---"
				cat pingresults.txt
				break
				;;
			"Display Port Scan Results" )
				echo -e "\n--- Port Scan Results ---"
				cat portscanresults.txt
				break
				;;
			"Remove Ping Sweep Results File" )
				rm pingresults.txt
				break
				;;
			"Remove Port Scan Results File" )
				rm portscanresults.txt
				break
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				break
				;;
		esac
	done
	while read -t 0.01; do :; done
	PrintScanResults
}

clear
MainMenu