package gov.ita.powerbi_gateway.public_data.sima;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface CensusRepository extends JpaRepository<Census, Long> {
  List<Census> findBySyear(Integer year);
}
