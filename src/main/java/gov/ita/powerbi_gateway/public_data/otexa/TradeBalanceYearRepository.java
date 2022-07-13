package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface TradeBalanceYearRepository extends JpaRepository<TradeBalanceYear, String> {
  List<TradeBalanceYear> findDistinctByOrderByTradeYearDesc();
}
