package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface MergedCategoryRepository extends JpaRepository<MergedCategory, String> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.MergedCategory(t.mergedCategory, t.description) from MergedCategory t order by t.mergedCategory")
  List<MergedCategory> findAllMergedCategories();
}
