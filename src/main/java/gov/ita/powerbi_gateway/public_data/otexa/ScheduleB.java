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
@Table(name = "OtexaSchedulebChapterRefVw")
public class ScheduleB {
  @Id
  @Column(name="SCHEDULE_B")
  public String scheduleB;
  public String longSchedb;
  public Long groupId;
  public Long catId;
  public Long chapter;
  public String longChapter;
  public String source;

  public ScheduleB (String scheduleB, String longSchedb) {
    super();
    this.scheduleB = scheduleB;
    this.longSchedb = longSchedb;
  }
}
