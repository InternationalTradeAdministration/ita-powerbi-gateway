package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface YearRepository extends JpaRepository<Year, Long> {
  List<Year> findDistinctHeaderDescriptionBySourceOrderByHeaderDescriptionDesc(String source);
}
