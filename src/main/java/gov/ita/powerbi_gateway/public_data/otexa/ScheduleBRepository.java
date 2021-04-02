package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ScheduleBRepository extends JpaRepository<ScheduleB, String> {
  List<ScheduleB> findDistinctScheduleBByGroupIdInAndChapterInAndSourceOrderByScheduleB(List<Long> exportGroups, List<Long> chapters, String source);

  List<ScheduleB> findDistinctScheduleBByGroupIdInAndSource(List<Long> groupIds, String source);

  List<ScheduleB> findDistinctScheduleBByChapterInAndSourceOrderByScheduleB(List<Long> chapters, String source);

  List<ScheduleB> findDistinctScheduleBByCatIdInAndChapterInAndSourceOrderByScheduleB(List<Long> categories, List<Long> chapters, String source);

  List<ScheduleB> findDistinctScheduleBByCatIdInAndSource(List<Long> categoryIds, String source);

}
