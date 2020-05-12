package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

@Data
public class PowerBiToken {
  private String token;
  private String expiration;
  private String tokenId;
}
