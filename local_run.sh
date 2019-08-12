#!/bin/bash
set -e
MYSQL_PORT=3306

function DockerStop() {
  CID=$1
  echo "Stopping docker container ${CID}"
  docker stop $CID
  echo "Stopped docker container ${CID}"
}

echo "Starting MySQL server in a docker container, listening on port ${MYSQL_PORT} on the host"
CID=$(docker run --rm --detach --name=mysqld-todoapi01-run --publish=${MYSQL_PORT}:3306 --env MYSQL_ROOT_PASSWORD=secret --env MYSQL_USER=app --env MYSQL_PASSWORD=app --env MYSQL_DATABASE=appdb mysql:8)
trap "DockerStop $CID" SIGINT SIGTERM
echo -n "Waiting for MySQL to come up"
while ! docker exec ${CID} sh -c "mysql --protocol TCP --user app --password=app --database appdb -e 'SELECT 1' > /dev/null 2>&1" > /dev/null 2>&1 ; do
  sleep 1
  echo -n .
done
echo Done

export SPRING_DATASOURCE_URL="jdbc:mysql://127.0.0.1:${MYSQL_PORT}/appdb?user=app&password=app"
set +e
echo "Starting App"
java -Dspring.datasource.url=${SPRING_DATASOURCE_URL} -jar build/libs/todoapi01-0.1.0.jar

echo "Stopping MySQL server"
DockerStop $CID