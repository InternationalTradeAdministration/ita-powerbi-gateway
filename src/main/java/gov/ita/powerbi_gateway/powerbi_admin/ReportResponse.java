package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

import java.util.List;

@Data
public class ReportResponse {
  private List<PowerBiReport> value;
}
