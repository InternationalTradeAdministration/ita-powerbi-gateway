package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ScheduleBRepository extends JpaRepository<ScheduleB, String> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ScheduleB(t.scheduleB, t.longSchedb) from ScheduleB t where t.groupId in :exportGroups and t.chapter in :chapters and t.source=:source order by t.scheduleB")
  List<ScheduleB> findByGroupAndChapter(List<Long> exportGroups, List<Long> chapters, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ScheduleB(t.scheduleB, t.longSchedb) from ScheduleB t where t.groupId in :groupIds and t.source=:source order by t.scheduleB")
  List<ScheduleB> findByGroup(List<Long> groupIds, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ScheduleB(t.scheduleB, t.longSchedb) from ScheduleB t where t.chapter in :chapters and t.source=:source order by t.scheduleB")
  List<ScheduleB> findByChapter(List<Long> chapters, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ScheduleB(t.scheduleB, t.longSchedb) from ScheduleB t where t.catId in :categories and t.chapter in :chapters and t.source=:source order by t.scheduleB")
  List<ScheduleB> findByCategoryAndChapter(List<Long> categories, List<Long> chapters, String source);

  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ScheduleB(t.scheduleB, t.longSchedb) from ScheduleB t where t.catId in :categoryIds and t.source=:source order by t.scheduleB")
  List<ScheduleB> findByCategory(List<Long> categoryIds, String source);

}
