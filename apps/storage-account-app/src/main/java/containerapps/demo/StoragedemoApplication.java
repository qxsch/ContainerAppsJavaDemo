package containerapps.demo;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class StoragedemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(StoragedemoApplication.class);
	}

	@Bean
	public OpenAPI customOpenAPI(@Value("1.0.0") String appVersion) {
		return new OpenAPI()
				.components(new Components())
				.info(
					new Info()
						.title("Container Apps Storage API")
						.description("This is a sample Spring Boot RESTful application for Azure Container Apps.")
						.version(appVersion)
						.license(new License().name("Apache 2.0").url("http://springdoc.org"))
				);
	}

}
