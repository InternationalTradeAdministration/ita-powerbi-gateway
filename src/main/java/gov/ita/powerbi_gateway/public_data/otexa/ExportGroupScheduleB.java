package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.Column;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExportGroupScheduleB implements Serializable {
  private static final long serialVersionUID = 1L;

  @Column(name="GROUP_ID")
  private Long groupId;

  @Column(name="SCHEDULE_B")
  private String scheduleB;
}
