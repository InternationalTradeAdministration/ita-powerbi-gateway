package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Token {
  String token;
  String tokenId;
  LocalDateTime expiration;
}
