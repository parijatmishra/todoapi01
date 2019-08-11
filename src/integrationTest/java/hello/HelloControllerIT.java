package hello;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;

import java.net.URL;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
// We don't want MovkMvc for this test
public class HelloControllerIT {

    // Get the random port assigned to the container - due to the RANDOM_PORT config above
    @LocalServerPort
    private int port;

    // Initialized in setUp
    private URL base;

    // Standard Spring Test utility
    @Autowired
    private TestRestTemplate template;

    @Before
    public void setUp() throws Exception {
        this.base = new URL("http://localhost:" + port + "/");
    }

    @Test
    public void getHello() throws Exception {
        final ResponseEntity<String> responseEntity = template.getForEntity(this.base.toString(), String.class);
        assertThat("Unexpected response", responseEntity.getBody(), equalTo("Greetings from Spring Boot!"));
    }
}
