package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ExportStatus {
  String resourceFileExtension;
  LocalDateTime createdDateTime;
  LocalDateTime expirationTime;
  String id;
  LocalDateTime lastActionDateTime;
  int percentComplete;
  String reportId;
  String reportName;
  String resourceLocation;
  String status;
}
