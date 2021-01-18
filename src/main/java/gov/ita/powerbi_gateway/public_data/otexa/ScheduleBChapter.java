package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Column;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "OtexaSchedulebChapterRefVw")
@IdClass(ExportGroupScheduleB.class)
public class ScheduleBChapter {
  @Id
  public Long groupId;

  @Id
  public Long catId;

  @Id
  @Column(name="SCHEDULE_B")

  public String scheduleB;

  public Long chapter;
  public String longChapter;
}
