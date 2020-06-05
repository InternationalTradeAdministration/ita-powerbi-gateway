package gov.ita.powerbi_gateway.public_data.sima;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "SimaSmpByHtsVw")
public class SteelMillProductHts {

  @Id
  private String htsCode;

  @ManyToOne
  @JoinColumns({
    @JoinColumn(name = "category", referencedColumnName = "category"),
    @JoinColumn(name = "grade2", referencedColumnName = "grade2")
  })
  private Census census;

  @Override
  public String toString() {
    return "SteelMillProductHts(htsCode=" + htsCode + ")";
  }
}
