# todoapi01

JSON API+server for TODO CRUD operations.

- Written in Java, using the Spring Boot frameowkr
- Uses Gradle for build
- Supports H2 and MySQL as Databases
- No authentication - don't leave it running on the internet!

# Development
## Build

    ./gradlew build

## Run

    java -jar build/libs/todoapi01-0.1.0.jar

Replace `0.1.0` with the current version.

## Test

### Basic
Manually, run the program (above) and:

Command:

    curl localhost:8080

Output:

    Greetings from Spring Boot!

Or, better, install [httpie](https://httpie.org/).

Command:

    http GET :8080/
 
 Output:
 
 ```
 HTTP/1.1 200
 Content-Length: 27
 Content-Type: text/plain;charset=UTF-8
 Date: Sun, 11 Aug 2019 05:48:28 GMT
 
 Greetings from Spring Boot!
 ```

## TODO
- Unit tests
- (Mock) Integration tests
