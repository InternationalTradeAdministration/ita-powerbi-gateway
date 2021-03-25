package gov.ita.powerbi_gateway.public_data.otexa;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ActiveProfiles("test")
@SpringBootTest
@AutoConfigureMockMvc
class OtexaControllerTest {

  @Autowired
  private CountryRepository countryRepository;

  @Autowired
  private CategoryRepository categoryRepository;

  @Autowired
  private HtsChapterRepository htsChapterRepository;

  @Autowired
  private HtsRepository htsRepository;

  @Autowired
  private MockMvc mockMvc;

  @Test
  public void otexa_controller_returns_countries() throws Exception {
    countryRepository.save(new Country(1L, 3L, "GREECE", "Europe", "MATRIX"));
    countryRepository.save(new Country(2L, 4L, "JAPAN", "Asia", "MATRIX"));
    mockMvc.perform(get("/api/otexa/countries?source=MATRIX"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].ctryId", is(1)))
      .andExpect(jsonPath("$[0].ctryDescription", is("GREECE")))
      .andExpect(jsonPath("$[1].ctryId", is(2)))
      .andExpect(jsonPath("$[1].ctryDescription", is("JAPAN")));
  }

  @Test
  public void otexa_controller_returns_categories() throws Exception {
    categoryRepository.save(new Category(1L, "Awesome", "MATRIX"));
    categoryRepository.save(new Category(2L, "Cool", "MATRIX"));
    mockMvc.perform(get("/api/otexa/categories?source=MATRIX"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].catId", is(1)))
      .andExpect(jsonPath("$[0].longCategory", is("Awesome")))
      .andExpect(jsonPath("$[1].catId", is(2)))
      .andExpect(jsonPath("$[1].longCategory", is("Cool")));
  }

  @Test
  public void otexa_controller_returns_distinct_chapters() throws Exception {
    htsChapterRepository.save(new HtsChapter("123123", 354L, 11L, "Very Awesome", "ANNUAL"));
    htsChapterRepository.save(new HtsChapter("333333", 359L, 22L, "Very Cool", "ANNUAL_FOOTWEAR"));
    htsChapterRepository.save(new HtsChapter("133334", 359L, 22L, "Very Cool", "ANNUAL"));
    mockMvc.perform(get("/api/otexa/chapters?source=ANNUAL"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].chapter", is(11)))
      .andExpect(jsonPath("$[0].longChapter", is("Very Awesome")))
      .andExpect(jsonPath("$[1].chapter", is(22)))
      .andExpect(jsonPath("$[1].longChapter", is("Very Cool")));
  }

  @Test
  public void otexa_controller_returns_hts_by_category() throws Exception {
    HtsChapter awesomeChapter = new HtsChapter("123123", 88L, 11L, "Very Awesome", "ANNUAL");
    Hts anAwesomeHts = new Hts("123123", "An Awesome HTS", 88L, 11L, "Very Awesome", "ANNUAL");
    htsRepository.save(anAwesomeHts);

    HtsChapter coolChapter = new HtsChapter("333333", 99L, 22L, "Very Cool", "ANNUAL");
    Hts aCoolHts = new Hts("333333", "A Cool HTS", 99L, 22L, "Very Cool", "ANNUAL");
    htsRepository.save(aCoolHts);

    mockMvc.perform(get("/api/otexa/hts?categories=88&source=ANNUAL"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(1)))
      .andExpect(jsonPath("$[0].hts", is("123123")))
      .andExpect(jsonPath("$[0].longHts", is("An Awesome HTS")));

    mockMvc.perform(get("/api/otexa/hts?categories=88,99&chapters=11,22&source=ANNUAL"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].hts", is("123123")))
      .andExpect(jsonPath("$[0].longHts", is("An Awesome HTS")))
      .andExpect(jsonPath("$[1].hts", is("333333")))
      .andExpect(jsonPath("$[1].longHts", is("A Cool HTS")));
  }

  @Test
  public void otexa_controller_returns_hts_by_chapter() throws Exception {
    HtsChapter awesomeChapter = new HtsChapter("123123", 88L, 11L, "Very Awesome", "EXPORT");
    Hts anAwesomeHts = new Hts("123123", "An Awesome HTS", 88L, 11L, "Very Awesome", "EXPORT");
    htsRepository.save(anAwesomeHts);

    HtsChapter coolChapter = new HtsChapter("333333", 99L, 22L, "Very Cool", "ANNUAL_FOOTWEAR");
    Hts aCoolHts = new Hts("333333", "A Cool HTS", 99L, 22L, "Very Cool", "ANNUAL_FOOTWEAR");
    htsRepository.save(aCoolHts);

    mockMvc.perform(get("/api/otexa/hts?chapters=11&source=EXPORT"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(1)))
      .andExpect(jsonPath("$[0].hts", is("123123")))
      .andExpect(jsonPath("$[0].longHts", is("An Awesome HTS")));
  }
}
