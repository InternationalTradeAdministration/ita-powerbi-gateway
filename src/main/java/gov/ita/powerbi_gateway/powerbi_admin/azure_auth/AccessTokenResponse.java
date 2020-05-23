package gov.ita.powerbi_gateway.powerbi_admin.azure_auth;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AccessTokenResponse {

  @JsonProperty("token_type")
  private String tokenType;

  @JsonProperty("expires_in")
  private Integer expiresIn;

  @JsonProperty("ext_expires_in")
  private Integer extExpiresIn;

  @JsonProperty("expires_on")
  private Integer expiresOn;

  @JsonProperty("not_before")
  private Integer notBefore;

  private String resource;

  @JsonProperty("access_token")
  private String accessToken;

  public AccessTokenResponse() {
  }

  public String getTokenType() {
    return tokenType;
  }

  public void setTokenType(String tokenType) {
    this.tokenType = tokenType;
  }

  public Integer getExpiresIn() {
    return expiresIn;
  }

  public void setExpiresIn(Integer expiresIn) {
    this.expiresIn = expiresIn;
  }

  public Integer getExtExpiresIn() {
    return extExpiresIn;
  }

  public void setExtExpiresIn(Integer extExpiresIn) {
    this.extExpiresIn = extExpiresIn;
  }

  public Integer getExpiresOn() {
    return expiresOn;
  }

  public void setExpiresOn(Integer expiresOn) {
    this.expiresOn = expiresOn;
  }

  public Integer getNotBefore() {
    return notBefore;
  }

  public void setNotBefore(Integer notBefore) {
    this.notBefore = notBefore;
  }

  public String getResource() {
    return resource;
  }

  public void setResource(String resource) {
    this.resource = resource;
  }

  public String getAccessToken() {
    return accessToken;
  }

  public void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }
}

