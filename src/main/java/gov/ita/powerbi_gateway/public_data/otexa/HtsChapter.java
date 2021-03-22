package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "OtexaHtsChapterRefVw")
@IdClass(CategoryHts.class)
public class HtsChapter {
  @Id
  public Long catId;
  @Id
  public String hts;

  public Long chapter;
  public String longChapter;
  public String source;
}
