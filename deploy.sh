#!/usr/bin/env bash
# Check if the reis instance running with the image name we are deploying
CURRENT_INSTANCE=$(sudo docker ps -a --filter ancestor="$DOCKER_USERNAME/$IMAGE_NAME" --format="{{.ID}}")
echo "Current Instance : " $CURRENT_INSTANCE
# If an instance does exist stop the instance
if [ "$CURRENT_INSTANCE" ]
then
    echo "Stopping current instance"
    sudo docker rm $(sudo docker stop $CURRENT_INSTANCE)
fi

# Pull down the instance from dockerhub
FULL_IMAGE_NAME="$DOCKER_USERNAME/$IMAGE_NAME"
echo "Full image name : " $FULL_IMAGE_NAME
sudo docker pull $FULL_IMAGE_NAME

# Check if a docker container exists with the name of node_app if it does remove the container
CONTAINER_EXISTS=$(sudo docker ps -a | grep $CONTAINER_NAME)
echo "Container Exists : " $CONTAINER_EXISTS
if [ "$CONTAINER_EXISTS" ]
then
    echo "Remove existing container"
	sudo docker stop $CONTAINER_NAME
    sudo docker rm $CONTAINER_NAME
fi

echo " about to run ..." 
sudo docker run -p 3000:3000 -d --name $CONTAINER_NAME $FULL_IMAGE_NAME 

#check that the container is actually up
sudo docker ps -a | grep $CONTAINER_NAME