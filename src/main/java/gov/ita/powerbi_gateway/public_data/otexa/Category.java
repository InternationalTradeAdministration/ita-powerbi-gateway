package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@AllArgsConstructor
@Table(name = "OtexaCategoryRefVw")
public class Category {
  @Id
  private Long catId;
  private String longCategory;
}
