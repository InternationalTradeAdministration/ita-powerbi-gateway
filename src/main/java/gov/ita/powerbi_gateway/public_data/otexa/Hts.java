package gov.ita.powerbi_gateway.public_data.otexa;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Data;

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

  @OneToOne
  @JsonIgnore
  @JoinColumn(name = "hts")
  public HtsChapter htsChapter;

  public Hts(String hts, String longHts) {
    this.hts = hts;
    this.longHts = longHts;
  }
}
