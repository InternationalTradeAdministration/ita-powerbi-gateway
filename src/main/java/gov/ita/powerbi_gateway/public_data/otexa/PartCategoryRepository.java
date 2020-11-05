package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface PartCategoryRepository extends JpaRepository<PartCategory, String> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.PartCategory(t.partCategory, t.category) from PartCategory t order by t.partCategory")
  List<PartCategory> findAllPartCategories();
}
