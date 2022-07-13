package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface TradeBalanceYearRepository extends JpaRepository<TradeBalanceYear, String> {
  @Query(value = "SELECT distinct new TradeBalanceYear(y.tradeYear) FROM TradeBalanceYear y ORDER BY 1 DESC")
  List<TradeBalanceYear> findAllDistinctTradeYears();
}
