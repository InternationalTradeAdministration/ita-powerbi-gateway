package gov.ita.powerbi_gateway.powerbi_admin.azure_auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class AccessTokenGateway {

  @Value("${powerbi.tenant-id}")
  private String tenantId;

  @Autowired
  private RestTemplate restTemplate;

  public byte[] getAccessToken(String clientId, String clientSecret, String resource) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

    MultiValueMap<String, String> tokenBody = new LinkedMultiValueMap<>();
    tokenBody.add("grant_type", "client_credentials");
    tokenBody.add("Content-Type", "application/x-www-form-urlencoded");
    tokenBody.add("cache-control", "no-cache");
    tokenBody.add("client_id", clientId);
    tokenBody.add("client_secret", clientSecret);
    tokenBody.add("Resource", resource);

    HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(tokenBody, headers);

    String authUrl = String.format("https://login.microsoftonline.com/%s/oauth2/token", tenantId);

    ResponseEntity<byte[]> accessTokenResponseEntity =
      restTemplate.exchange(authUrl, HttpMethod.POST, tokenRequest, byte[].class);
    return accessTokenResponseEntity.getBody();
  }
}
