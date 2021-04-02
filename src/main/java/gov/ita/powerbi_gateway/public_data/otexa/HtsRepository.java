package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface HtsRepository extends JpaRepository<Hts, String> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.Hts(t.hts, t.longHts) from Hts t where t.catId in :categories and t.chapter in :chapters and t.source=:source order by t.hts")
  List<Hts> findByCategoryAndChapter(List<Long> categories, List<Long> chapters, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.Hts(t.hts, t.longHts) from Hts t where t.catId in :categoryIds and t.source=:source order by t.hts")
  List<Hts> findByCategory(List<Long> categoryIds, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.Hts(t.hts, t.longHts) from Hts t where t.chapter in :chapters and t.source=:source order by t.hts")
  List<Hts> findByChapter(List<Long> chapters, String source);
}
