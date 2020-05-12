package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

@Data
public class PowerBiGroup {
  private String id;
  private String name;
  private Boolean isOnDedicatedCapacity;
}
