#! /bin/bash

# Jacob Boesen, Sascha Scheidegger, and Hannah Ohm
# CI 201

# This file contains a series of useful functions to manage a system. It helps to manage disks, files, networks, processes, and contains utilies that help the user perform miscellaneous tasks.

MainMenu() {
	echo -e "\n-------Main Menu-------"
	select choice in "Disk Management" "File Management" "Network Management" "Process Management" "User Account Management" "Utilities" "Exit Program"
	do
		case $choice in
			"Disk Management" )
				DiskManagement
				;;
			"File Management" )
				FileManagement
				;;
			"Network Management" )
				NetworkManagement
				;;
			"Process Management" )
				ProcessManagement
				;;
			"User Account Management" )
				UserAccountManagement
				;;
			"Utilities" )
				Utilities
				;;
			"Exit Program" )
				echo "Exiting the program."
				exit 0
				;;
			* )
				echo "Invalid selection."
				MainMenu
				;;
		esac
	done
}

DiskManagement() {
	echo -e "\n-------Disk Management-------"
	select choice in "Display Device Information" "Display Disk Partition Information" "Display Block Device Information" "Display Mounted Disk Information" "Return to Main Menu"
	do
		case $choice in
			"Display Device Information" )
				ls -l /dev
				DiskManagement
				;;
			"Display Disk Partition Information" )
				sudo fdisk -l
				DiskManagement
				;;
			"Display Block Device Information" )
				lsblk
				DiskManagement
				;;
			"Display Mounted Disk Information" )
				df
				DiskManagement
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				DiskManagement
				;;
		esac
	done
}

FileManagement() {
	echo -e "\n-------File Management-------"
	select choice in "Present Working Directory" "List Directory Contents" "Create a File" "Change File Permissions" "Remove a File" "Read a File" "Return to Main Menu"
	do
		case $choice in
			"Present Working Directory" )
				echo "The current directory you are working in is: "
				pwd
				FileManagement
				;;
			"List Directory Contents" )
				echo "The contents of the directory that you are in are: "
				ls
				FileManagement
				;;
			"Create a File" )
				read -p "Name the file that you want to create with the tag (ex: file.txt): " CreateFile
				touch $CreateFile
				echo "$CreateFile has been created."
				FileManagement
				;;
			"Change File Permissions" )
				read -p "Enter file that you would like to change permissions of: " file

				echo "---OPTIONS LIST---"
				echo "1. Read, Write, and Execute"
				echo "2. Read and Write"
				echo "3. Read and Execute"
				echo "4. Just Read"
				echo "5. Write and Execute"
				echo "6. Just Write"
				echo "7. Just Execute"
				echo "8. Nothing"

				i=1
				continue=true
				while [ $continue = "true" ]
				do
					if [ $i -eq 1 ]
					then
						read -p "What permissions should the file owner have? " p1
					elif [ $i -eq 2 ]
					then
						read -p "What permissions should the file group owner have? " p2
					else
						read -p "What permissions should everyone else have? " p3
					fi

					if [ $i -eq 1 ]
					then
						if [ $p1 -ge 1 ] && [ $p1 -le 8 ]
						then
							((i++))
						else
							echo "Invalid selection."
						fi
					elif [ $i -eq 2 ]
					then
						if [ $p2 -ge 1 ] && [ $p2 -le 8 ]
						then
							((i++))
						else
							echo "Invalid selection."
						fi
					else
						if [ $p3 -ge 1 ] && [ $p3 -le 8 ]
						then
							continue=false;
						else
							echo "Invalid selection."
						fi
					fi
				done

				p1=$((8-p1))
				p2=$((8-p2))
				p3=$((8-p3))

				chmod $p1$p2$p3 $file
				echo "Permissions for $file have been changed."
				FileManagement
				;;
			"Remove a File" )
				read -p "Name the file that you want to remove: " DelFile
				rm -f $DelFile
				FileManagement
				;;
			"Read a File" )
				read -p "Name the file that you want to read: " CatFile
				cat $CatFile
				FileManagement
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				FileManagement
				;;
			esac
	done
}

NetworkManagement() {
	echo -e "\n-------Network Management-------"
	select choice in "ifconfig" "ping" "traceroute" "nslookup" "View Network Interfaces" "View Network Routing Table" "View Current System Users" "View Client Machine Information" "Return to Main Menu"
	do
		case $choice in
			"ifconfig" )
				echo "Your system information is: "
				ifconfig
				NetworkManagement
				;;
			"ping" )
				read -p "Enter the IP address that you want to ping (ex 192.168.0.1): " ip
				ping -c4 $ip
				NetworkManagement
				;;
			"traceroute" )
				read -p "Enter the IP address that you want to trace: " ip
				traceroute $ip
				NetworkManagement
				;;
			"nslookup" )
				read -p "Enter the IP or Url of host you want to identify: " ip
				nslookup $ip
				NetworkManagement
				;;
			"View Network Interfaces" )
				netstat -i
				NetworkManagement
				;;
			"View Network Routing Table" )
				netstat -r
				NetworkManagement
				;;
			"View Current System Users" )
				w
				NetworkManagement
				;;
			"View Client Machine Information" )
				uname -a
				NetworkManagement
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				NetworkManagement
				;;
		esac
	done
}

ProcessManagement() {
	echo -e "\n-------Process Management-------"
	select choice in "Display Processes" "Display Processes by Usage" "Terminate a Process" "Display Disk Usage" "Display Free Disk Space" "Display System Uptime" "Return to Main Menu"
	do
		case $choice in
			"Display Processes" )
				ps aux
				ProcessManagement
				;;
			"Display Processes by Usage" )
				top
				ProcessManagement
				;;
			"Terminate a Process" )
				read -p "Enter process to kill: " KillProccess
				sudo kill -9 $KillProcess
				ProcessManagement
				;;
			"Display Disk Usage" )
				df -h
				ProcessManagement
				;;
			"Display Free Disk Space" )
				df -h
				ProcessManagement
				;;
			"Display System Uptime" )
				uptime
				ProcessManagement
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				ProcessManagement
				;;
		esac
	done
}

UserAccountManagement() {
	echo -e "\n-------User Account Management-------"
	select choice in "Add User" "Delete User" "Lock User Password" "Get Information on User" "Add Group" "Delete Group" "Find User" "Find Group" "Return to Main Menu"
	do
		case $choice in
			"Add User" )
				read -p "Enter the name of the user you'd like to add: " user
				sudo useradd $user
				UserAccountManagement
				;;
			"Delete User" )
				read -p "Enter the name of the user you'd like to remove: " user
				sudo userdel $user
				UserAccountManagement
				;;
			"Lock User Password" )
				read -p "Enter the name of the user you'd like to lock: " user
				sudo passwd -l $user
				UserAccountManagement
				;;
			"Get Information on User" )
				read -p "Enter the name of the user you'd like to get information on: " user
				id $user
				UserAccountManagement
				;;
			"Add Group" )
				read -p "Enter in desired group name: " groupname
				if [ `grep $groupname /etc/group | wc -l` -eq 1 ]
				then
					echo "That group name already exists on this machine."
					# exits out of "Add Group" - user needs to run command again if they really want to add a new group 
					# reasoning: maybe user did not check beforehand using "Find Group" to see if the group they want to add already exists
					# and now doesn't want to add a new group anymore - this way they don't have to terminate the script to do so.
				else
					continue=true
					while [ $continue = "true" ]
					do
						read -p "Choose a group ID from 1000 to 9999: " gid # this is just an arbitrary range for putting custom groups out of the way of everything else
						if [ $gid -ge 1000 ] && [ $gid -le 9999 ]
						then
							if [ `grep $gid /etc/group | wc -l` -eq 1 ]
							then
								echo "That GID value already exists for a group on this machine."
							else
								continue=false
							fi
						else
							echo "Invalid selection."
						fi
					done
					sudo groupadd -g $gid $groupname
				fi
				UserAccountManagement
				;;
			"Delete Group" )
				read -p "Enter the name of the group you'd like to delete: " user
				sudo groupdel $user
				UserAccountManagement
				;;
			"Find User" )
				read -p "Enter the user you'd like to search for: " user
				if [ `grep $user /etc/passwd | wc -l` -eq 0 ]
				then
					echo "That user does not exist on this machine."
				else
					grep $user /etc/passwd
				fi
				UserAccountManagement
				;;
			"Find Group" )
				read -p "Enter the group you'd like to search for: " group
				if [ `grep $group /etc/group | wc -l` -eq 0 ]
				then
					echo "That group does not exist on this machine."
				else
					grep $group /etc/group
				fi
				UserAccountManagement
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				UserAccountManagement
				;;
		esac
	done
}

Utilities() {
	echo -e "\n-------Utilities-------"
	select choice in "Date/Time" "Calendar" "View Manual (man) Pages" "Determine File Type" "Determine Command Type" "Sort File" "Search File" "Return to Main Menu"
	do
		case $choice in
			"Date/Time" )
				date
				Utilities
				;;
			"Calendar" )
        		cal
				Utilities
				;;
			"View Manual (man) Pages" )
				read -p "Enter command you want to view manual pages of: " CommandMan
				man $CommandMan
				Utilities
				;;
			"Determine File Type" )
        		read -p "Enter file you want to know the type of: " fileType
				file $fileType
				Utilities
				;;
			"Determine Command Type" )
        		read -p "Enter command you want to know the type of: " commandType
				type $commandType
				Utilities
				;;
			"Sort File" )
				read -p "What is the name of the file you would like to sort: " file1
				read -p "What would you like to name the sorted file: " file2
				sort -o $file2 $file1
				Utilities
				;;
			"Search File" )
				read -p "What is the name of the file you would like to search: " file1
				read -p "What would you like to name results file: " file2
				read -p "What is the search parameter: " searchTerm
				grep $searchTerm $file1 > $file2
				Utilities
				;;
			"Return to Main Menu" )
				MainMenu
				;;
			* )
				echo "Invalid selection."
				Utilities
				;;
		esac
	done
}

MainMenu