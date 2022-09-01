#!/bin/bash

# $1 is name $2 is replicas $3 is choice
#create temp file
gitaddr_temp=$(mktemp -t test.XXX)
                                
#input git addr
dialog --title "Git Repository" --inputbox "Pls Input Git Repositoy address, where index.html exist" 10 50 2>$gitaddr_temp
git_addr=$(cat $gitaddr_temp)
if [[ $? -eq 0 ]] && [[ -n $git_addr ]]
then
	#last confirm before deploy
	dialog --title "Information Confirmation" --yesno "Pls Confirm your Selection before deploy\n Stack name : $1 \n Service : $3 \n Stack replicas : $2 \n git address : $git_addr " 10 70
	if [ $? -eq 0 ]
	then
        	if [[ "$3" == "nginx" ]]
                then
                /home/rapa/jdss/scripts/makenginx/createstack.sh $1 $2 $git_addr > /dev/null
               
		elif [[ "$3" == "httpd" ]]
		then
	        /home/rapa/jdss/scripts/makehttpd/createstack.sh $1 $2 $git_addr > /dev/null
                fi
		if [ $? -eq 0 ]
                then
                	#get STACK INFORMATION

                	network_ip=$(docker network inspect $1 | grep Subnet | gawk {'print $2'} | tr -d ',' | tr -d '"')
                	network_subnet=$(docker network inspect $1 | grep Gateway | gawk {'print $2'} |  tr -d '"')
                	network_scope=$(docker network inspect $1 -f "{{.Scope}}")
                	network_driver=$(docker network inspect $1 -f "{{.Driver}}")
                	host_port=$(docker service inspect ${1}_proxy -f "{{.Endpoint.Ports"}} | gawk '{print $4}')
I
                	#show STACK INFORMATION
                	dialog --title "WORK COMPLETE" --msgbox "STACK DEPLOY COMPLETE\n Network Ip : $network_ip \n Network Subnet : $network_subnet \n Network_Scope : $network_scope \n Network Driver : $network_driver \n Access Port : $host_port" 10 80

                fi

        fi

fi

#delete Temp file
rm -rf $gitaddr_temp 2> /dev/null
