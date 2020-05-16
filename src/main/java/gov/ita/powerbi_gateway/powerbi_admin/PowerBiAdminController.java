package gov.ita.powerbi_gateway.powerbi_admin;

import gov.ita.powerbi_gateway.powerbi_admin.azure_auth.AccessTokenGateway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/pbi-admin", produces = MediaType.APPLICATION_JSON_VALUE)
public class PowerBiAdminController {

  @Autowired
  private AccessTokenGateway accessTokenGateway;

  @GetMapping(value = "/get-access-token", produces = MediaType.APPLICATION_JSON_VALUE)
  public byte[] getAccessToken() {
    return accessTokenGateway.getAccessToken();
  }

}
