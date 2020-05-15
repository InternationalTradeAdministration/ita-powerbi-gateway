package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Profile({"staging", "production"})
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
  public List<Country> getCountries() {
    return countryRepository.findAll();
  }

  @Override
  public List<Category> getCategories() {
    return categoryRepository.findAll();
  }

  @Override
  public List<Chapter> getChapters() {
    return htsChapterRepository.findAllChapters();
  }

  @Override
  public List<Hts> hetAllHts() {
    return htsRepository.findAll();
  }
}
