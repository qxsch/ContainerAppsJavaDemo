package containerapps.demo;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@Tag(name = "Hello", description = "the Hello API")
@RequestMapping("/api/hello")
public class HelloController {

    @PutMapping("/{name}")
    @ResponseStatus(HttpStatus.OK)
    public String sayHello(@PathVariable("name") final String name) {
        return "hello " + name;
    }
}

