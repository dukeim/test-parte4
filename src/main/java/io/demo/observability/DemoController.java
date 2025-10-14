package io.demo.observability;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

@RestController
@RequestMapping("/api")
public class DemoController {
    private final Random random = new Random();

    @GetMapping("/hello")
    public String hello() throws InterruptedException {
        int delay = random.nextInt(500); // up to 500ms
        Thread.sleep(delay);
        if (random.nextInt(10) < 2) { // 20% chance of error
            throw new RuntimeException("Random failure (simulated)");
        }
        return "Hello after " + delay + "ms";
    }
}
