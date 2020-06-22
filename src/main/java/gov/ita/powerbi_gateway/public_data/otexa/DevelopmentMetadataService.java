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
  public List<Category> getCategories(String source) {
    return Arrays.asList(
      new Category(1L, "1 - Frogs", "ANNUAL"),
      new Category(2L, "2 - Cows", "ANNUAL")
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
