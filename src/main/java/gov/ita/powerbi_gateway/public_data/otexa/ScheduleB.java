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
@Table(name = "OtexaSchedulebRefVw")
@IdClass(ExportGroupScheduleB.class)
public class ScheduleB {
  @Id
  @JsonIgnore
  public Long groupId;

  @Id
  public String scheduleB;

  public String longSchedb;

  @JsonIgnore
  @MapsId
  @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  @JoinColumns({
      @JoinColumn(name = "GROUP_ID"),
      @JoinColumn(name = "SCHEDULE_B")
  })
  public ScheduleBChapter scheduleBChapter;


  public ScheduleB(String scheduleB, String longSchedb) {
    this.scheduleB = scheduleB;
    this.longSchedb = longSchedb;
  }
}
