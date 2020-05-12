package gov.ita.powerbi_gateway.powerbi_admin;

import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Objects;

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

  @GetMapping("/get-access-token")
  public AccessTokenResponse getAccessToken() {
    return accessTokenGateway.getAccessToken(clientId, clientSecret, resourceUrl);
  }

  @GetMapping("/list-groups")
  public List<PowerBiGroup> listGroups(@RequestParam String accessToken) {
    HttpHeaders headers = buildHeader(accessToken);
    String groupsApi = apiUrl + "/v1.0/myorg/groups";
    ResponseEntity<GroupResponse> responseEntity =
      restTemplate.exchange(groupsApi, HttpMethod.GET, buildHttpEntity(headers, "parameters"), GroupResponse.class);
    return Objects.requireNonNull(responseEntity.getBody()).getValue();
  }

  @GetMapping("/list-reports")
  public List<PowerBiReport> listReports(@RequestParam String groupId, @RequestParam String accessToken) {
    HttpHeaders headers = buildHeader(accessToken);
    String reportsApi = apiUrl + "/v1.0/myorg/groups/" + groupId + "/reports";
    ResponseEntity<ReportResponse> responseEntity =
      restTemplate.exchange(reportsApi, HttpMethod.GET, buildHttpEntity(headers, "parameters"), ReportResponse.class);
    return Objects.requireNonNull(responseEntity.getBody()).getValue();
  }

  @GetMapping("/get-report")
  public PowerBiReportToken getReport(@RequestParam String groupId, @RequestParam String reportId, @RequestParam String accessToken) {
    HttpHeaders headers = buildHeader(accessToken);

    String reportsApi = apiUrl + "/v1.0/myorg/groups/" + groupId + "/reports/" + reportId;
    ResponseEntity<PowerBiReport> reportResponseEntity =
      restTemplate.exchange(reportsApi, HttpMethod.GET, buildHttpEntity(headers, "parameters"), PowerBiReport.class);

    String generateTokenApi = reportsApi + "/GenerateToken";
    ResponseEntity<PowerBiToken> tokenResponseEntity =
      restTemplate.exchange(generateTokenApi, HttpMethod.POST, buildHttpEntity(headers, "{ accessLevel: 'View' }"), PowerBiToken.class);

    return new PowerBiReportToken(reportResponseEntity.getBody(), tokenResponseEntity.getBody());
  }

  private HttpEntity<String> buildHttpEntity(HttpHeaders headers, String body) {
    return new HttpEntity<>(body, headers);
  }

  private HttpHeaders buildHeader(String accessToken) {
    HttpHeaders headers = new HttpHeaders();
    headers.set("Authorization", "Bearer " + accessToken);
    headers.setContentType(MediaType.APPLICATION_JSON);
    return headers;
  }

}
