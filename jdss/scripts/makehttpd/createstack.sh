#!/bin/bash

#creake dir for git clone and get index.html from git
mkdir /home/rapa/jdss/webpage/$1
git clone --quiet $3 /home/rapa/jdss/webpage/$1/ > /dev/null

#it goes to dir, where Dockerfile exist

cp /home/rapa/jdss/webpage/$1/index.html /home/rapa/jdss/dockerfile_dir/httpd/index.html

#login
docker login 211.183.3.103:80 -uadmin -ptest123 > /dev/null 2>&1

#image build and push

docker build -t 211.183.3.103:80/jdss_repo/${1}_httpd:v1 /home/rapa/jdss/dockerfile_dir/httpd/.
docker push 211.183.3.103:80/jdss_repo/${1}_httpd:v1

#modify stack yml file
cp /home/rapa/jdss/ymls/httpd_service_base.yml /home/rapa/jdss/ymls/httpd_service.yml
sed -i "s/setname/$1/" /home/rapa/jdss/ymls/httpd_service.yml
sed -i "s/set_network/$1/g" /home/rapa/jdss/ymls/httpd_service.yml
sed -i "s/set_replicas/$2/" /home/rapa/jdss/ymls/httpd_service.yml

if [ $? -eq 0 ]
then
        #docker network create - overlay

        docker network create -d overlay $1

        #docker stack deploy

        docker stack deploy -c /home/rapa/jdss/ymls/httpd_service.yml --with-registry-auth $1
        if [ $? -eq 0 ]
        then
                #Delete created file and image

                rm -rf /home/rapa/jdss/ymls/httpd_service.yml
                rm -rf /home/rapa/jdss/webpage/$1
                rm -rf /home/rapa/jdss/dockerfile_dir/httpd/index.html
                docker image rm 211.183.3.103:80/jdss_repo/${1}_httpd:v1

        fi
fi
