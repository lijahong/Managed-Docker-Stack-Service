#!/bin/bash
# $1 is name $2 is replicas
#last confirm before deploy

dialog --title "Information Confirmation" --yesno "Pls Confirm your Selection before deploy\n Stack name : $1 \n Service : $3 \n Stack replicas : $2 \n " 10  50
if [ $? -eq 0 ]
then
	cp /home/rapa/jdss/ymls/wp_service_base.yml /home/rapa/jdss/ymls/wp_service.yml
	sed -i "s/setname/$1/g" /home/rapa/jdss/ymls/wp_service.yml
	sed -i "s/set_replicas/$2/" /home/rapa/jdss/ymls/wp_service.yml

	if [ $? -eq 0 ]
	then
        	#docker network create - overlay

        	docker network create -d overlay $1 > /dev/null

        	#docker stack deploy

        	docker stack deploy -c /home/rapa/jdss/ymls/wp_service.yml --with-registry-auth $1 > /dev/null
		#notify mysql information
		dialog --title "DB INFORMATION" --msgbox " USER : root \n PASSWORD : test123 \n DB NAME : testdb \n " 10 40
                #Delete created file and image
                rm -rf /home/rapa/jdss/ymls/wp_service.yml
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
