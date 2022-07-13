package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
@Profile("development")
public class DevelopmentMetadataService implements MetadataService {
  @Override
  public List<Country> getCountries(String source) {
    return Arrays.asList(
      new Country(3L, "WORLD", "Country Groups", "ANNUAL"),
      new Country(4L, "GREECE", "Europe", "ANNUAL")
    );
  }

  @Override
  public List<Year> getYears() {
    return Arrays.asList(
      new Year("1989"),
      new Year("Year Ending Apr/2020"),
      new Year("Stardate 42523.7")
    );
  }

  @Override
  public List<FootwearYear> getFootwearYears() {
    return Arrays.asList(
      new FootwearYear("Y_2019"),
      new FootwearYear("Y_2020_YTD")
    );
  }

  @Override
  public List<MonthlyYear> getMonthlyYears(String source) {
    return Arrays.asList(
      new MonthlyYear(2020L, "MONTHLY"),
      new MonthlyYear(2021L, "MONTHLY")
    );
  }

  @Override
  public List<TradeBalanceYear> getTradeBalanceYears() {
    return Arrays.asList(
       new TradeBalanceYear("YTD 2022"),
       new TradeBalanceYear("2021")
    );
  }
  @Override
  public List<Category> getCategories(String source) {
    return Arrays.asList(
      new Category(1L, "1 - Frogs", "ANNUAL"),
      new Category(2L, "2 - Cows", "ANNUAL")
    );
  }

  @Override
  public List<MergedCategory> getMergedCategories() {
    return Arrays.asList(
      new MergedCategory("123 456", "1 - Frogs"),
      new MergedCategory("789 012", "2 - Cows")
    );
  }

  @Override
  public List<PartCategory> getPartCategories() {
    return Arrays.asList(
      new PartCategory("345 678", "3 - Salamanders"),
      new PartCategory("901 234", "4 - Ocelots")
    );
  }

  @Override
  public List<ExportGroup> getExportGroups() {
    return Arrays.asList(
      new ExportGroup(4L, "42 - W&G Suit-type Coats"),
      new ExportGroup(5L, "58 - Accessories")
    );
  }

  @Override
  public List<Chapter> getChapters(String source) {
    return Arrays.asList(
      new Chapter(1L, "1 - Matrix"),
      new Chapter(2L, "2 - Logan"),
      new Chapter(3L, "3 - Frank Slade")
    );
  }

  @Override
  public List<Chapter> getScheduleBChapters(String source) {
    return Arrays.asList(
      new Chapter(4L, "4 - Maxwell"),
      new Chapter(5L, "5 - Wu"),
      new Chapter(6L, "6 - Franklin")
    );
  }

  @Override
  public List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source) {
    return Arrays.asList(
      new Hts("123456", "123456 - Bumbleflex", 1L, 39L, "39 - Other things", "ANNUAL"),
      new Hts("123321", "123321 - Nanofiber", 2L, 39L, "42 - Luggage locks", "ANNUAL_FOOTWEAR")
    );
  }

  @Override
  public List<Hts> getHtsByCategories(List<Long> categoryIds, String source) {
    return Arrays.asList(
      new Hts("123456", "123456 - Rayon", 1L, 39L, "39 - Other things", "ANNUAL"),
      new Hts("123321", "123321 - Modal", 2L, 42L, "42 - Luggage locks", "ANNUAL_FOOTWEAR"),
      new Hts("123323", "123323 - Chainmail", 3L, 56L, "56 - Plastic stuff", "ANNUAL")
    );
  }

  @Override
  public List<Hts> getHtsByChapters(List<Long> chapters, String source) {
    return Arrays.asList(
      new Hts("123456", "123456 - Rayon", 1L, 39L, "39 - Other things", "ANNUAL"),
      new Hts("123321", "123321 - Modal", 2L, 42L, "42 - Luggage locks", "ANNUAL_FOOTWEAR")
    );
  }

  @Override
  public List<ScheduleB> getScheduleBByExportGroupsAndChapters(List<Long> exportGroups, List<Long> chapters, String source) {
    return Arrays.asList(
      new ScheduleB("123456", "123456 - Woven Etc", 1L, 2L, 39L, "39 - Other things", "EXPORT"),
      new ScheduleB("123321", "123321 - Metallic", 3L, 4L, 42L, "42 - Luggage locks", "EXPORT_FOOTWEAR")
    );
  }

  @Override
  public List<ScheduleB> getScheduleBByExportGroups(List<Long> groupIds, String source) {
    return Arrays.asList(
      new ScheduleB("123456", "123456 - Woven Etc", 1L, 2L, 39L, "39 - Other things", "EXPORT"),
      new ScheduleB("123321", "123321 - Metallic", 3L, 4L, 42L, "42 - Luggage locks", "EXPORT_FOOTWEAR"),
      new ScheduleB("123323", "123323 - Polyester", 5L, 6L, 56L, "56 - Plastic stuff", "EXPORT")
    );
  }

  @Override
  public List<ScheduleB> getScheduleBByChapters(List<Long> chapters, String source) {
    return Arrays.asList(
      new ScheduleB("123456", "123321 - Metallic", 3L, 4L, 39L, "39 - Other things", "EXPORT"),
      new ScheduleB("123323", "123456 - Woven Etc", 1L, 5L, 42L, "42 - Luggage locks", "EXPORT_FOOTWEAR")
    );
  }

  @Override
  public List<ScheduleB> getScheduleBByCategoriesAndChapters(List<Long> categories, List<Long> chapters, String source) {
    return Arrays.asList(
      new ScheduleB("123456", "123456 - Woven Etc", 1L, 2L, 39L, "39 - Other things", "EXPORT"),
      new ScheduleB("123321", "123321 - Metallic", 3L, 4L, 42L, "42 - Luggage locks", "EXPORT_FOOTWEAR")
    );
  }

  @Override
  public List<ScheduleB> getScheduleBByCategories(List<Long> categoryIds, String source) {
    return Arrays.asList(
      new ScheduleB("123456", "123456 - Woven Etc", 1L, 2L, 39L, "39 - Other things", "EXPORT"),
      new ScheduleB("123321", "123321 - Metallic", 3L, 4L, 42L, "42 - Luggage locks", "EXPORT_FOOTWEAR"),
      new ScheduleB("123323", "123323 - Polyester", 5L, 6L, 56L, "56 - Plastic stuff", "EXPORT")
    );
  }

}
