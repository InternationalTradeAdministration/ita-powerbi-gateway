package gov.ita.powerbi_gateway.public_data.otexa;

import java.util.List;

public interface MetadataService {
  List<Country> getCountries(String source);

  List<Category> getCategories(String source);

  List<MergedCategory> getMergedCategories();

  List<PartCategory> getPartCategories();

  List<ExportGroup> getExportGroups();

  List<Chapter> getChapters(String source);

  List<Chapter> getScheduleBChapters(String source);

  List<Year> getYears();

  List<FootwearYear> getFootwearYears();

  List<MonthlyYear> getMonthlyYears(String source);

  List<TradeBalanceYear> getTradeBalanceYears();

  List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source);

  List<Hts> getHtsByCategories(List<Long> categoryIds, String source);

  List<Hts> getHtsByChapters(List<Long> chapters, String source);

  List<ScheduleB> getScheduleBByExportGroupsAndChapters(List<Long> exportGroups, List<Long> chapters, String source);

  List<ScheduleB> getScheduleBByExportGroups(List<Long> groupIds, String source);

  List<ScheduleB> getScheduleBByChapters(List<Long> chapters, String source);

  List<ScheduleB> getScheduleBByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source);

  List<ScheduleB> getScheduleBByCategories(List<Long> categoryIds, String source);

}
