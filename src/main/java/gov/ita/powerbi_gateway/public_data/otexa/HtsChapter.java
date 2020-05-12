package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "OtexaHtsChapterRefVw")
public class HtsChapter {
  @Id
  public String hts;
  public Long chapter;
  public String longChapter;
}
