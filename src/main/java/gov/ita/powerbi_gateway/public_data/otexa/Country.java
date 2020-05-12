package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "OtexaCountryRef")
public class Country {
  @Id
  private Long ctryId;
  private String ctryDescription;
}
