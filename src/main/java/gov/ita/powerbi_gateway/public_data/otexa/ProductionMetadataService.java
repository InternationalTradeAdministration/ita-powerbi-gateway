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
  private HtsChapterRepository htsChapterRepository;

  @Autowired
  private HtsRepository htsRepository;

  @Override
  public List<Country> getCountries(String source) {
    return countryRepository.findBySource(source);
  }

  @Override
  public List<Category> getCategories(String source) {
    return categoryRepository.findBySource(source);
  }

  @Override
  public List<Chapter> getChapters() {
    return htsChapterRepository.findAllChapters();
  }

  @Override
  public List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters) {
    return htsRepository.findByCatIdInAndHtsChapterChapterInOrderByHts(categories, chapters);
  }

  @Override
  public List<Hts> getHtsByCategories(List<Long> categoryIds) {
    return htsRepository.findByCatIdIn(categoryIds);
  }

  @Override
  public List<Hts> getHtsByChapters(List<Long> chapters) {
    return htsRepository.findByHtsChapterChapterInOrderByHts(chapters);
  }
}
