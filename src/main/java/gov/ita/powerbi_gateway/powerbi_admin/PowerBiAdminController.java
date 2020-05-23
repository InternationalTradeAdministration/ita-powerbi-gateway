package gov.ita.powerbi_gateway.powerbi_admin;

import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
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
  private final String apiUrl = "https://api.powerbigov.us/v1.0/myorg";
  private AccessTokenResponse accessTokenResponse;

  public PowerBiAdminController(AccessTokenGateway accessTokenGateway, RestTemplate restTemplate) {
    this.accessTokenGateway = accessTokenGateway;
    this.restTemplate = restTemplate;
  }

  @GetMapping("/groups")
  public Groups getGroups(@RequestParam(required = false) String workspaceName) {
    checkAccessTokenExpiration();
    String groupsUrl = buildUrl("/groups", workspaceName);
    return restTemplate.exchange(groupsUrl, HttpMethod.GET, new HttpEntity<>(buildHeaders()), Groups.class).getBody();
  }

  @GetMapping("/reports")
  public Reports getReportsByGroupName(@RequestParam String workspaceName) {
    Group group = getGroups(workspaceName).getValue().get(0);
    return getReports(group.getId(), null);
  }

  @GetMapping("/generate-token")
  public ReportToken generateToken(@RequestParam String workspaceName, @RequestParam String reportName) {
    Group group = getGroups(workspaceName).getValue().get(0);
    Report report = getReports(group.getId(), reportName).getValue().get(0);
    String url = apiUrl + "/groups/" + group.getId() + "/reports/" + report.getId() + "/GenerateToken";
    Token token = restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>("{ \"accessLevel\": \"view\" }", buildHeaders()), Token.class).getBody();
    return new ReportToken(report, token);
  }

  private Reports getReports(String groupId, String reportName) {
    String url = buildUrl("/groups/" + groupId + "/reports", reportName);
    return restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(buildHeaders()), Reports.class).getBody();
  }

  private String buildUrl(String endPoint, String filterParam) {
    return apiUrl + endPoint + buildFilter(filterParam);
  }

  private String buildFilter(String filterParam) {
    return (filterParam != null) ? "?$filter=name eq '" + filterParam + "'" : "";
  }

  private void checkAccessTokenExpiration() {
    if (accessTokenResponse == null || (accessTokenResponse.getExpiresOn() < System.currentTimeMillis() / 1000)) {
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
