package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

@Data
public class PowerBiReport {
  private String id;
  private String reportType;
  private String name;
  private String webUrl;
  private String embedUrl;
  private Boolean isFromPbix;
  private String datasetId;
}
