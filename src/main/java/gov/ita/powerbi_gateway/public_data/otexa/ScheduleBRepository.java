package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ScheduleBRepository extends JpaRepository<ScheduleB, String> {
  List<ScheduleB> findByGroupIdInAndScheduleBChapterChapterInOrderByScheduleB(List<Long> exportGroups, List<Long> chapters);

  List<ScheduleB> findByGroupIdIn(List<Long> groupIds);

  List<ScheduleB> findByScheduleBChapterChapterInOrderByScheduleB(List<Long> chapters);

  List<ScheduleB> findByCatIdInAndScheduleBChapterChapterInOrderByScheduleB(List<Long> categories, List<Long> chapters);

  List<ScheduleB> findByCatIdIn(List<Long> categoryIds);

}
