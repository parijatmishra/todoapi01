# todoapi01

JSON API+server for TODO CRUD operations.

- Written in Java, using the Spring Boot frameowkr
- Uses Gradle for build
- Supports H2 and MySQL as Databases
- No authentication - don't leave it running on the internet!

## Build

Compile, run unit tests and generate "uberJar" aka "bootJar":

    ./gradlew build

## Run

Run the bootJar:

    java -jar build/libs/todoapi01-0.1.0.jar


Replace `0.1.0` with the current version.

Call API using CURL:

    curl localhost:8080

Output:

    Greetings from Spring Boot!

Or, better, install [httpie](https://httpie.org/). Call API:

    http GET :8080/
 
 Output:
 
 ```
 HTTP/1.1 200
 Content-Length: 27
 Content-Type: text/plain;charset=UTF-8
 Date: Sun, 11 Aug 2019 05:48:28 GMT
 
 Greetings from Spring Boot!
 ```

## Test

Run both unit and integration test (see note for integration tests):

    `./gradlew check`

### Unit Tests

Run tests in the `src/test/java` durectory:

    ./gradlew test [--info]
    
Test results are generated as HTML files in folder:

    build/reports/tests/test/

### Integration Tests

Run tests in the `src/integrationTest/java` directory:

    ./gradlew integrationTest [--info]

Test results are generated as HTML files in folder:

    build/reports/tests/integrationTest
