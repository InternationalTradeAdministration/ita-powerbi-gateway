package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

@Data
public class Report {
  String id;
  String name;
  String reportType;
  String webUrl;
  String embedUrl;
  Boolean isFromPbix;
  Boolean isOwnedByMe;
  String datasetId;
}
