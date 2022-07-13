package gov.ita.powerbi_gateway.public_data.otexa;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "OtexaTradeBalanceYearsVw")
public class TradeBalanceYear {
  @Id
  @Column(name="[Trade Year]")
  private String tradeYear;

}
