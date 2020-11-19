package gov.ita.powerbi_gateway.public_data.otexa;

import java.util.List;

public interface MetadataService {
  List<Country> getCountries(String source);

  List<Category> getCategories(String source);

  List<MergedCategory> getMergedCategories();

  List<PartCategory> getPartCategories();

  List<Chapter> getChapters();

  List<Year> getYears();

  List<FootwearYear> getFootwearYears();

  List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters);

  List<Hts> getHtsByCategories(List<Long> categoryIds);

  List<Hts> getHtsByChapters(List<Long> chapters);
}
