#!/bin/bash  

CONTAINER_NAME="tmodloader"  


if ! docker ps -a | grep $CONTAINER_NAME; then
	echo "container is not running"
	docker compose up -d
fi

echo "launching server"
docker compose exec $CONTAINER_NAME ./start-tModLoaderServer.sh

