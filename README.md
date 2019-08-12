# todoapi01

JSON API+server for TODO CRUD operations.

- Written in Java, using the Spring Boot framework
- MySQL as database (H2 for unit-tests)
- Uses Gradle for build
- No authentication - don't leave it running on the internet!

## Compiling

You don't need to run this explicitly as it is done as part of unit tests, packaging or integration test phases automatically.  But you can do so if you want:

    ./gradlew compileJava

## Running Unit Tests

The `test` task runs unit tests (those in the `src/test/java` directory):

    ./gradlew test [--info]
    
Test results are generated as HTML files in the `build/reports/tests/test/` folder.

Unit tests use an embedded H2 database automatically.

## Packaging: Creating an UberJar/BootJar

The `build` task compiles application and test source code, runs unit tests, and generates and "uberJar" aka "bootJar":

    ./gradlew build
 
## Running

The script `local_run.sh` will do step 1-3 and 5 below. **Note**: it needs Docker.

  1. The program needs a MySQL database.  You need to find out the *hostname*, *port*, *schema* (db in MySQL terminology), *user* and *password*.
  
     For development, you can start one using docker, like this:

     `CID=$(docker run --rm --detach --name=mysqld-inttest --publish=3306:3306 --env MYSQL_ROOT_PASSWORD=secret --env MYSQL_USER=app --env MYSQL_PASSWORD=app --env MYSQL_DATABASE=appdb mysql:8)`

  2. Define the JDBC URL:
  
     `JDBC_URL="jdbc:mysql://127.0.0.1:3306/appdb?user=app&password=app"`

  3. Run the bootJar, passing the JDBC_URL as a JVM property:

     `java -Dspring.datasource.url=${JDBC_URL} -jar build/libs/todoapi01-0.1.0.jar`

     See [Connection to a Production Database](https://docs.spring.io/spring-boot/docs/2.1.7.RELEASE/reference/html/boot-features-sql.html#boot-features-connect-to-production-database) in the Spring documentation for other configuration options you could use.

     The application starts listening on port `8080` by default.  You can [change this in a few ways](https://docs.spring.io/spring-boot/docs/2.1.7.RELEASE/reference/html/howto-embedded-web-servers.html#howto-change-the-http-port), for e.g., by specifying `-Dserver.port=X` on the command line.

  4. You can interact with the application using curl:
  
     ```
     $ curl localhost:8080/
     Greetings from Spring Boot!
     ```

     Or, using [httpie](https://httpie.org/):
     
     ```
     $ http GET :8080/
     HTTP/1.1 200
     Content-Length: 27
     Content-Type: text/plain;charset=UTF-8
     Date: Sun, 11 Aug 2019 05:48:28 GMT
     
     Greetings from Spring Boot!      
     ```

  5. Once you are done, don't forget to stop the MySQL container:

     `docker stop $CID`

## Running Integration Tests

The script `local_integrationTest.sh` will do the following steps for you (**Note**: it requires Docker):
 
 - run a MySQL server in a docker container;
 - define an environment variable `SPRING_DATASOURCE_URL`, containing a JDBC URL pointing to the above MySQL server;
 - run the integration tests;
 - terminate the MySQL server docker container.

If you want to use some other MySQL server, define the environment variable `SPRING_DATASOURCE_URL`, and invoke the integration tests:

    ./gradlew integrationTest [--info]

Test results are generated as HTML files in the `build/reports/tests/integrationTest` folder.

