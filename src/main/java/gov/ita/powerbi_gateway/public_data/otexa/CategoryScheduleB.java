package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.Column;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryScheduleB implements Serializable {
  private static final long serialVersionUID = 1L;

  private Long catId;

  @Column(name="SCHED_B")
  private String scheduleB;
}
