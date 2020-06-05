package gov.ita.powerbi_gateway.public_data.sima;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/sima")
@Profile("production")
public class SimaController {

  @Value("${GATEWAY_API_TOKEN}")
  private String token;

  @Autowired
  private CensusRepository censusRepository;

  @GetMapping("/census")
  public ResponseEntity<List<Census>> getCensus(@RequestParam String token, @RequestParam String year) {
    if (!this.token.equals(token)) return ResponseEntity.badRequest().build();
    return ResponseEntity.ok(censusRepository.findBySyear(Integer.parseInt(year)));
  }
}
