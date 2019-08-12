#!/bin/bash
set -e
MYSQL_PORT=13306 # pick a port that is not likely to conflict with other running programs

function DockerStop() {
  CID=$1
  echo "Stopping docker container ${CID}"
  docker stop $CID
  echo "Stopped docker container ${CID}"
}

echo "Starting MySQL server in a docker container, listening on port ${MYSQL_PORT} on the host"
CID=$(docker run --rm --detach --name=mysqld-inttest --publish=${MYSQL_PORT}:3306 --env MYSQL_ROOT_PASSWORD=secret --env MYSQL_USER=app --env MYSQL_PASSWORD=app --env MYSQL_DATABASE=appdb mysql:8)
trap "DockerStop $CID" SIGINT SIGTERM
echo -n "Waiting for MySQL to come up"
while ! docker exec ${CID} sh -c "mysql --protocol TCP --user app --password=app --database appdb -e 'SELECT 1' > /dev/null 2>&1" > /dev/null 2>&1 ; do
  sleep 1
  echo -n .
done
echo Done

export SPRING_DATASOURCE_URL="jdbc:mysql://127.0.0.1:${MYSQL_PORT}/appdb?user=app&password=app"
set +e
./gradlew integrationTest --info

echo "Stopping MySQL server"
DockerStop $CID