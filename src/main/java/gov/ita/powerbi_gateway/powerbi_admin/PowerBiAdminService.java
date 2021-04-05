package gov.ita.powerbi_gateway.powerbi_admin;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Service
public class PowerBiAdminService {
  public static final int ACCESS_TOKEN_REFRESH_WINDOW = 6 * 60;
  private final String apiUrl = "https://api.powerbigov.us/v1.0/myorg";

  private final RestTemplate restTemplate;
  private final AccessTokenGateway accessTokenGateway;
  private AccessTokenResponse accessTokenResponse;

  public PowerBiAdminService(AccessTokenGateway accessTokenGateway,
                             RestTemplate restTemplate) {
    this.accessTokenGateway = accessTokenGateway;
    this.restTemplate = restTemplate;
  }

  public Groups getPbiGroups(String workspaceName) {
    checkAccessTokenExpiration();
    URI uri = buildUri("/groups", workspaceName);
    return restTemplate.exchange(uri, HttpMethod.GET, new HttpEntity<>(buildHeaders()), Groups.class).getBody();
  }

  public Reports getPbiReports(String groupId, String reportName) {
    URI uri = buildUri("/groups/" + groupId + "/reports", reportName);
    return restTemplate.exchange(uri, HttpMethod.GET, new HttpEntity<>(buildHeaders()), Reports.class).getBody();
  }

  public Token generatePbiEmbedToken(String groupId, String reportId) {
    String url = apiUrl + "/groups/" + groupId + "/reports/" + reportId + "/GenerateToken";
    return restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>("{ \"accessLevel\": \"view\" }", buildHeaders()), Token.class).getBody();
  }

  public ExportStatus exportToFileInGroup(String groupId,
                                          String reportId,
                                          String bookmarkState,
                                          String format) throws JsonProcessingException {
    String url = apiUrl + "/groups/" + groupId + "/reports/" + reportId + "/ExportTo";
    String requestBody = buildExportToFileRequestBody(bookmarkState, format);
    return restTemplate.exchange(
        url,
        HttpMethod.POST,
        new HttpEntity<>(requestBody, buildHeaders()),
        ExportStatus.class).getBody();
  }

  public ExportStatus getExportToFileStatusInGroup(String groupId,
                                                   String reportId,
                                                   String exportStatusId) {
    String url = apiUrl + "/groups/" + groupId + "/reports/" + reportId + "/exports/" + exportStatusId;
    return restTemplate.exchange(
        url,
        HttpMethod.GET,
        new HttpEntity<>(buildHeaders()),
        ExportStatus.class).getBody();
  }

  public byte[] getFileOfExportToFileInGroup(String groupId,
                                             String reportId,
                                             String exportStatusId) {
    String url = apiUrl + "/groups/" + groupId + "/reports/" + reportId + "/exports/" + exportStatusId + "/file";
    return restTemplate.exchange(
        url,
        HttpMethod.GET,
        new HttpEntity<>(buildHeaders()),
        byte[].class).getBody();
  }

  private URI buildUri(String endPoint, String filterParam) {
    UriComponentsBuilder builder = UriComponentsBuilder.fromUriString(apiUrl + endPoint);
    if (filterParam != null) {
      builder.queryParam("$filter",
          URLEncoder.encode("name eq '" + escapeSingleQuote(filterParam) + "'", StandardCharsets.UTF_8));
    }
    return builder.build(true).toUri();
  }

  private String escapeSingleQuote(String filterParam) {
    return filterParam.replaceAll("'", "''");
  }

  private HttpHeaders buildHeaders() {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.add("Authorization", "Bearer " + accessTokenResponse.getAccessToken());
    return headers;
  }

  private void checkAccessTokenExpiration() {
    if (accessTokenResponse == null || (accessTokenResponse.getExpiresOn() <= (LocalDateTime.now().toEpochSecond(ZoneOffset.UTC) + ACCESS_TOKEN_REFRESH_WINDOW))) {
      accessTokenResponse = accessTokenGateway.getAccessToken();
    }
  }

  private String buildExportToFileRequestBody(String bookmarkState, String format) throws JsonProcessingException {
    ObjectMapper mapper = new ObjectMapper();
    ObjectNode body = mapper.createObjectNode();
    body.put("format", format);

    ObjectNode defaultBookmark = mapper.createObjectNode();
    defaultBookmark.put("state", bookmarkState);

    ObjectNode powerBIReportConfiguration = mapper.createObjectNode();
    powerBIReportConfiguration.set("defaultBookmark", defaultBookmark);
    body.set("powerBIReportConfiguration", powerBIReportConfiguration);

    return mapper.writeValueAsString(body);
  }
}
