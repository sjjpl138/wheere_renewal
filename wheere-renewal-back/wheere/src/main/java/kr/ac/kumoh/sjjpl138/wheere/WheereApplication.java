package kr.ac.kumoh.sjjpl138.wheere;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import java.util.Optional;
import java.util.UUID;

@EnableJpaAuditing
@SpringBootApplication
public class WheereApplication {

	public static void main(String[] args) {
		SpringApplication.run(WheereApplication.class, args);
	}
}
