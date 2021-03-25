package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface HtsRepository extends JpaRepository<Hts, String> {
  List<Hts> findDistinctByCatIdInAndChapterInAndSourceOrderByHts(List<Long> categories, List<Long> chapters, String source);

  List<Hts> findDistinctByCatIdInAndSource(List<Long> categoryIds, String source);

  List<Hts> findDistinctByChapterInAndSourceOrderByHts(List<Long> chapters, String source);
}
