package gov.ita.powerbi_gateway.powerbi_admin;

import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value = "/api/pbi-admin", produces = MediaType.APPLICATION_JSON_VALUE)
public class PowerBiAdminController {

  @Value("${powerbi.client-id}")
  private String clientId;
  @Value("${powerbi.client-secret}")
  private String clientSecret;
  @Value("${powerbi.resource-url}")
  private String resourceUrl;
  @Value("${powerbi.api-url}")
  private String apiUrl;
  @Autowired
  private RestTemplate restTemplate;
  @Autowired
  private AccessTokenGateway accessTokenGateway;

  @GetMapping(value = "/get-access-token", produces = MediaType.APPLICATION_JSON_VALUE)
  public byte[] getAccessToken() {
    return accessTokenGateway.getAccessToken(clientId, clientSecret, resourceUrl);
  }

}
