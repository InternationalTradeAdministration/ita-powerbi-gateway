package gov.ita.powerbi_gateway.version;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VersionController {

  @Value("${build-id}")
  private String buildId;

  @GetMapping("/api/version")
  public String getVersion() {
    return "v1.0.0_beta_" + buildId;
  }
}
