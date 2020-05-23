package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class PowerBiGroups {
  List<Group> value;
}
