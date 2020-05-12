package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface HtsRepository extends JpaRepository<Hts, String> {
  List<Hts> findByCatIdIn(List<Long> categories);
  List<Hts> findByHtsChapterChapterIn(List<Long> chapters);
  List<Hts> findByCatIdInAndHtsChapterChapterIn(List<Long> categories, List<Long> chapters);
}
