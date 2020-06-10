package gov.ita.powerbi_gateway.public_data.sima;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Entity
@Table(name = "SimaCensusVw")
public class Census implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  private Long id;
  private String country;
  private Double value;
  private Double netton;
  private Double avgnetpr;
  private Double qtymt;
  private Double avgmetpr;
  private Integer smonth;
  private Integer syear;
  private String steelType;
  private String grade2;
  private String category;

  @JsonIgnore
  @OneToMany(targetEntity = SteelMillProductHts.class, mappedBy = "census", fetch = FetchType.EAGER)
  private List<SteelMillProductHts> steelMillProductHts;

  @JsonProperty("hts_10_codes")
  String getHts10Codes() {
    return steelMillProductHts.stream().map(SteelMillProductHts::getHtsCode).collect(Collectors.joining(", "));
  }

  @Override
  public String toString() {
    return "Census (id=" + id + ")";
  }

}
