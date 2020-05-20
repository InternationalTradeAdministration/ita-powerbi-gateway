package gov.ita.powerbi_gateway.public_data.otexa;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "OtexaHtsRefVw")
public class Hts {
  @Id
  public String hts;
  public String longHts;

  @JsonIgnore
  public Long catId;

  @JsonIgnore
  @OneToOne(cascade = CascadeType.ALL)
  @JoinColumn(name = "hts")
  public HtsChapter htsChapter;

  public Hts(String hts, String longHts) {
    this.hts = hts;
    this.longHts = longHts;
  }
}
