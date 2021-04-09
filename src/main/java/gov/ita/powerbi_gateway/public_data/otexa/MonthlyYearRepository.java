package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface MonthlyYearRepository extends JpaRepository<MonthlyYear, Long> {
  List<MonthlyYear> findBySource(String source);
}
