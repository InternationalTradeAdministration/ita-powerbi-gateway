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
      new Country(1L, "WORLD", "ANNUAL"),
      new Country(2L, "GREECE", "ANNUAL")
    );
  }

  @Override
  public List<ExportCountry> getExportCountries() {
    return Arrays.asList(
      new ExportCountry("WORLD"),
      new ExportCountry("BANGLADESH")
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
      new ExportGroup(42),
      new ExportGroup(38)
    );
  }

  @Override
  public List<Chapter> getChapters() {
    return Arrays.asList(
      new Chapter(1L, "1 - Matrix"),
      new Chapter(2L, "2 - Logan"),
      new Chapter(3L, "3 - Frank Slade")
    );
  }

  @Override
  public List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters) {
    return Arrays.asList(new Hts("123456", "123456 - Socks"), new Hts("123321", "123321 - Hats"));
  }

  @Override
  public List<Hts> getHtsByCategories(List<Long> categoryIds) {
    return Arrays.asList(
      new Hts("123456", "123456 - Socks"),
      new Hts("123321", "123321 - Hats"),
      new Hts("123323", "123323 - Shoes")
    );
  }

  @Override
  public List<Hts> getHtsByChapters(List<Long> chapters) {
    return Arrays.asList(
      new Hts("123456", "123456 - Socks"),
      new Hts("123323", "123323 - Shoes")
    );
  }
}
