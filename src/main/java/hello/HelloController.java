package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HelloController {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot!";
    }

    @RequestMapping("/selectOne")
    public String selectOne() {
        return jdbcTemplate.getJdbcOperations()
                .queryForObject("SELECT 1", Integer.class)
                .toString();
    }
}
