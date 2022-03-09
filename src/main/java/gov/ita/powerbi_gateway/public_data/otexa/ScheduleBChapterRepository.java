package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ScheduleBChapterRepository extends JpaRepository<ScheduleBChapter, Long> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.Chapter(t.chapter, t.longChapter) from ScheduleBChapter t where t.source=:source ORDER BY t.chapter ASC")
  List<Chapter> findBySource(String source);
}
