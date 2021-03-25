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
@Table(name = "OtexaHtsChapterRefVw")
public class Hts {
  @Id
  public String hts;
  public String longHts;
  public Long catId;
  public Long chapter;
  public String longChapter;
  public String source;
}
