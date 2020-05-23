package gov.ita.powerbi_gateway.powerbi_admin;

import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenResponse;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value = "/api/pbi-admin", produces = MediaType.APPLICATION_JSON_VALUE)
public class PowerBiAdminController {

  private final AccessTokenGateway accessTokenGateway;
  private final RestTemplate restTemplate;
  private final String apiUrl = "https://api.powerbigov.us";
  private AccessTokenResponse accessTokenResponse;

  public PowerBiAdminController(AccessTokenGateway accessTokenGateway, RestTemplate restTemplate) {
    this.accessTokenGateway = accessTokenGateway;
    this.restTemplate = restTemplate;
    this.accessTokenResponse = accessTokenGateway.getAccessToken();
  }

  @GetMapping("/groups")
  public PowerBiGroups getPowerBiGroups(@RequestParam(required = false) String workspaceName) {
    checkTokenExpiration();
    String groupsApiUrl = apiUrl + "/v1.0/myorg/groups";
    String url = (workspaceName != null) ? groupsApiUrl + "?$filter=name eq '" + workspaceName + "'" : groupsApiUrl;
    ResponseEntity<PowerBiGroups> exchange = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(buildHeaders()), PowerBiGroups.class);
    return exchange.getBody();
  }

  @GetMapping("/reports")
  public PowerBiReports getPowerBiReports(@RequestParam String workspaceName) {
    checkTokenExpiration();
    PowerBiGroups powerBiGroups = getPowerBiGroups(workspaceName);
    String groupId = powerBiGroups.getValue().get(0).getId();
    return getReportsByGroupId(groupId, null);
  }

  @GetMapping("/generate-token")
  public PowerBiReportToken getPowerBiEmbedToken(@RequestParam String workspaceName, @RequestParam String reportName) {
    checkTokenExpiration();
    String groupId = getPowerBiGroups(workspaceName).getValue().get(0).getId();
    Report report = getReportsByGroupId(groupId, reportName).getValue().get(0);
    String url = apiUrl + "/v1.0/myorg/groups/"+groupId+"/reports/"+report.getId()+"/GenerateToken";
    ResponseEntity<Token> exchange =
      restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>("{ \"accessLevel\": \'view\' }", buildHeaders()), Token.class);
    return new PowerBiReportToken(report, exchange.getBody());
  }

  private PowerBiReports getReportsByGroupId(String groupId, String reportName) {
    String reportsApiUrl = apiUrl + "/v1.0/myorg/groups/"+groupId+"/reports";
    String url = (reportName != null) ? reportsApiUrl + "?$filter=name eq '" + reportName + "'" : reportsApiUrl;
    ResponseEntity<PowerBiReports> exchange = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(buildHeaders()), PowerBiReports.class);
    return exchange.getBody();
  }

  private void checkTokenExpiration() {
    if (accessTokenResponse.getExpiresOn() < System.currentTimeMillis() / 1000) {
      accessTokenResponse = accessTokenGateway.getAccessToken();
    }
  }

  private HttpHeaders buildHeaders() {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.add("Authorization", "Bearer " + accessTokenResponse.getAccessToken());
    return headers;
  }
}
