package gov.ita.powerbi_gateway.public_data.otexa;

import java.util.List;

public interface MetadataService {
  List<Country> getCountries();
  List<Category> getCategories();
  List<Chapter> getChapters();
  List<Hts>   getHtsByCategories(List<Long> categories);
  List<Hts> getHtsByChapters(List<Long> chapters);
  List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters);
}
