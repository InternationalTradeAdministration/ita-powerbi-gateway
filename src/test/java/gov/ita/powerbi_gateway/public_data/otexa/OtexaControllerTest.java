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
    countryRepository.save(new Country(1L, "GREECE", "MATRIX"));
    countryRepository.save(new Country(2L, "JAPAN",  "MATRIX"));
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
    htsChapterRepository.save(new HtsChapter(354L, "123123", 11L, "Very Awesome"));
    htsChapterRepository.save(new HtsChapter(359L, "333333", 22L, "Very Cool"));
    htsChapterRepository.save(new HtsChapter(359L, "133334", 22L, "Very Cool"));
    mockMvc.perform(get("/api/otexa/chapters"))
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
    HtsChapter awesomeChapter = new HtsChapter(88L, "123123", 11L, "Very Awesome");
    Hts anAwesomeHts = new Hts(88L,"123123", "An Awesome HTS", awesomeChapter);
    htsRepository.save(anAwesomeHts);

    HtsChapter coolChapter = new HtsChapter(99L, "333333", 22L, "Very Cool");
    Hts aCoolHts = new Hts(99L, "333333", "A Cool HTS", coolChapter);
    htsRepository.save(aCoolHts);

    mockMvc.perform(get("/api/otexa/hts?categories=88"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(1)))
      .andExpect(jsonPath("$[0].hts", is("123123")))
      .andExpect(jsonPath("$[0].longHts", is("An Awesome HTS")));

    mockMvc.perform(get("/api/otexa/hts?categories=88,99&chapters=11,22"))
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
    HtsChapter awesomeChapter = new HtsChapter(88L, "123123", 11L, "Very Awesome");
    Hts anAwesomeHts = new Hts(88L,"123123", "An Awesome HTS", awesomeChapter);
    htsRepository.save(anAwesomeHts);

    HtsChapter coolChapter = new HtsChapter(99L, "333333", 22L, "Very Cool");
    Hts aCoolHts = new Hts(99L, "333333", "A Cool HTS", coolChapter);
    htsRepository.save(aCoolHts);

    mockMvc.perform(get("/api/otexa/hts?chapters=11"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(1)))
      .andExpect(jsonPath("$[0].hts", is("123123")))
      .andExpect(jsonPath("$[0].longHts", is("An Awesome HTS")));
  }
}
