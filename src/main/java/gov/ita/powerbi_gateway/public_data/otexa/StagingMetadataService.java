package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@Profile({"staging"})
public class StagingMetadataService implements MetadataService {

  @Override
  public List<Country> getCountries() {
    return Collections.emptyList();
  }

  @Override
  public List<Category> getCategories() {
    return Collections.emptyList();
  }

  @Override
  public List<Chapter> getChapters() {
    return Collections.emptyList();
  }

  @Override
  public List<Hts> getHtsByCategoriesAndChapters(List<Long> categories, List<Long> chapters) {
    return Collections.emptyList();
  }
}
