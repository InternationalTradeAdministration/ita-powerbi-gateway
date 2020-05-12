package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PowerBiReportToken {
  private PowerBiReport powerBiReport;
  private PowerBiToken powerBiToken;
}
