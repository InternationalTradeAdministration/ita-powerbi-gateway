package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Profile({"production", "staging", "test"})
public class ProductionMetadataService implements MetadataService {

  @Autowired
  private CountryRepository countryRepository;

  @Autowired
  private CategoryRepository categoryRepository;

  @Autowired
  private MergedCategoryRepository mergedCategoryRepository;

  @Autowired
  private PartCategoryRepository partCategoryRepository;

  @Autowired
  private ExportGroupRepository exportGroupRepository;

  @Autowired
  private HtsChapterRepository htsChapterRepository;

  @Autowired
  private HtsRepository htsRepository;

  @Autowired
  private ScheduleBChapterRepository scheduleBChapterRepository;

  @Autowired
  private ScheduleBRepository scheduleBRepository;

  @Autowired
  private YearRepository yearRepository;

  @Autowired
  private FootwearYearRepository footwearYearRepository;

  @Autowired
  private MonthlyYearRepository monthlyYearRepository;

  @Autowired
  private TradeBalanceYearRepository tradeBalanceYearRepository;

  @Override
  public List<Country> getCountries(String source) {
    return countryRepository.findBySourceOrderByCtryDescription(source);
  }

  @Override
  public List<Year> getYears() {
    return yearRepository.findAllYears();
  }

  @Override
  public List<FootwearYear> getFootwearYears() {
    return footwearYearRepository.findAllFootwearYears();
  }

  @Override
  public List<MonthlyYear> getMonthlyYears(String source) {
    return monthlyYearRepository.findBySource(source);
  }

  @Override
  public List<Category> getCategories(String source) {
    return categoryRepository.findBySource(source);
  }

  @Override
  public List<MergedCategory> getMergedCategories() {
    return mergedCategoryRepository.findAllMergedCategories();
  }

  @Override
  public List<PartCategory> getPartCategories() {
    return partCategoryRepository.findAllPartCategories();
  }

  @Override
  public List<ExportGroup> getExportGroups() {
    return exportGroupRepository.findAllExportGroups();
  }

  @Override
  public List<Chapter> getChapters(String source) {
    return htsChapterRepository.findBySource(source);
  }

  @Override
  public List<Chapter> getScheduleBChapters(String source) {
    return scheduleBChapterRepository.findBySource(source);
  }

  @Override
  public List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source) {
    return htsRepository.findByCategoryAndChapter(categories, chapters, source);
  }

  @Override
  public List<Hts> getHtsByCategories(List<Long> categoryIds, String source) {
    return htsRepository.findByCategory(categoryIds, source);
  }

  @Override
  public List<Hts> getHtsByChapters(List<Long> chapters, String source) {
    return htsRepository.findByChapter(chapters, source);
  }

  @Override
  public List<ScheduleB> getScheduleBByExportGroupsAndChapters(List<Long> exportGroups, List<Long> chapters, String source) {
    return scheduleBRepository.findByGroupAndChapter(exportGroups, chapters, source);
  }

  @Override
  public List<ScheduleB> getScheduleBByExportGroups(List<Long> groupIds, String source) {
    return scheduleBRepository.findByGroup(groupIds, source);
  }

  @Override
  public List<ScheduleB> getScheduleBByChapters(List<Long> chapters, String source) {
    return scheduleBRepository.findByChapter(chapters, source);
  }

  @Override
  public List<ScheduleB> getScheduleBByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source) {
    return scheduleBRepository.findByCategoryAndChapter(categories, chapters, source);
  }

  @Override
  public List<ScheduleB> getScheduleBByCategories(List<Long> categoryIds, String source) {
    return scheduleBRepository.findByCategory(categoryIds, source);
  }

  @Override
  public List<TradeBalanceYear> getTradeBalanceYears() {
    return tradeBalanceYearRepository.findDistinctByOrderByTradeYearDesc();
  }

}
