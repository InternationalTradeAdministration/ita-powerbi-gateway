package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ExportCountryRepository extends JpaRepository<ExportCountry, String> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ExportCountry(t.country) from ExportCountry t order by t.country")
  List<ExportCountry> findAllExportCountries();
}
