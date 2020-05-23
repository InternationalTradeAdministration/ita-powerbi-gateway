package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

@Data
public class Group {
  String id;
  String name;
  Boolean isReadOnly;
  Boolean isOnDedicatedCapacity;
  String capacityId;
}
