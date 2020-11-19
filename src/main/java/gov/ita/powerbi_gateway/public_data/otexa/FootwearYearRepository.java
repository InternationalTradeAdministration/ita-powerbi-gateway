package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface FootwearYearRepository extends JpaRepository<FootwearYear, Long> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.FootwearYear(t.DataKey) from FootwearYear t order by t.DataKey desc")
  List<FootwearYear> findAllFootwearYears();
}
