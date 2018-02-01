#!/bin/sh
for block in $(docker stack ps koto --filter="name=${1}" --filter="desired-state=running" --format "{{.ID}}")
do
  container_id=`docker inspect -f "{{.Status.ContainerStatus.ContainerID}}" ${block}`
  docker exec -it ${container_id} "${@:2:($#)}"
done
