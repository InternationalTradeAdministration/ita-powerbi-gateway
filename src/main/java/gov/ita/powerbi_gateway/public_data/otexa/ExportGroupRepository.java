package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
interface ExportGroupRepository extends JpaRepository<ExportGroup, Long> {
  @Query("select distinct new gov.ita.powerbi_gateway.public_data.otexa.ExportGroup(t.groupId, t.longGroup) from ExportGroup t order by t.groupId asc")
  List<ExportGroup> findAllExportGroups();
}
