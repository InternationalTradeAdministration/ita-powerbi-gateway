package gov.ita.powerbi_gateway.public_data.otexa;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/otexa", produces = MediaType.APPLICATION_JSON_VALUE)
public class OtexaController {

  @Autowired
  private MetadataService metadataService;

  @GetMapping("/countries")
  public List<Country> getCountries(@RequestParam String source) {
    return metadataService.getCountries(source);
  }

  @GetMapping("/years")
  public List<Year> getYears() {
    return metadataService.getYears();
  }

  @GetMapping("/categories")
  public List<Category> getCategories(@RequestParam String source) {
    return metadataService.getCategories(source);
  }

  @GetMapping("/chapters")
  public List<Chapter> getChapters() {
    return metadataService.getChapters();
  }

  @GetMapping("/hts")
  public List<Hts> getHts(@RequestParam(required = false) List<String> categories, @RequestParam(required = false) List<String> chapters) {
    if ((categories != null && categories.size() > 0) && (chapters != null && chapters.size() > 0)) {
      List<Long> categoryIds = categories.stream().map(Long::parseLong).collect(Collectors.toList());
      List<Long> chapterIds = chapters.stream().map(Long::parseLong).collect(Collectors.toList());
      return metadataService.getHtsByCategoriesAndChapters(categoryIds, chapterIds);
    }

    if (categories != null && categories.size() > 0) {
      List<Long> categoryIds = categories.stream().map(Long::parseLong).collect(Collectors.toList());
      return metadataService.getHtsByCategories(categoryIds);
    }

    if (chapters != null && chapters.size() > 0) {
      List<Long> chapterIds = chapters.stream().map(Long::parseLong).collect(Collectors.toList());
      return metadataService.getHtsByChapters(chapterIds);
    }

    return Collections.emptyList();
  }

}
