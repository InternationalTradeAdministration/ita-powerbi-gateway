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
  private MockMvc mockMvc;

  @Test
  public void returns_countries() throws Exception {
    countryRepository.save(new Country(1L, "GREECE"));
    countryRepository.save(new Country(2L, "JAPAN"));
    mockMvc.perform(get("/api/otexa/countries"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].ctryId", is(1)))
      .andExpect(jsonPath("$[0].ctryDescription", is("GREECE")))
      .andExpect(jsonPath("$[1].ctryId", is(2)))
      .andExpect(jsonPath("$[1].ctryDescription", is("JAPAN")));
  }

  @Test
  public void returns_categories() throws Exception {
    categoryRepository.save(new Category(1L, "Awesome"));
    categoryRepository.save(new Category(2L, "Cool"));
    mockMvc.perform(get("/api/otexa/categories"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].catId", is(1)))
      .andExpect(jsonPath("$[0].longCategory", is("Awesome")))
      .andExpect(jsonPath("$[1].catId", is(2)))
      .andExpect(jsonPath("$[1].longCategory", is("Cool")));
  }

  @Test
  public void returns_chapters() throws Exception {
    htsChapterRepository.save(new HtsChapter("123123", 11L, "Very Awesome"));
    htsChapterRepository.save(new HtsChapter("333333", 22L, "Very Cool"));
    mockMvc.perform(get("/api/otexa/chapters"))
      .andExpect(status().isOk())
      .andExpect(content().contentType(MediaType.APPLICATION_JSON))
      .andExpect(jsonPath("$", hasSize(2)))
      .andExpect(jsonPath("$[0].chapter", is(11)))
      .andExpect(jsonPath("$[0].longChapter", is("Very Awesome")))
      .andExpect(jsonPath("$[1].chapter", is(22)))
      .andExpect(jsonPath("$[1].longChapter", is("Very Cool")));
  }

}
