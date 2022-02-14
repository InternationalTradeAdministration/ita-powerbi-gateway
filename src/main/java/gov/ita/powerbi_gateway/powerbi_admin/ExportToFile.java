package gov.ita.powerbi_gateway.powerbi_admin;

import lombok.Data;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

@Data
public class ExportToFile {

    @NotEmpty
    private String workspaceName;

    @NotEmpty
    private String reportName;

    @NotEmpty
    private String bookmarkState;

    @Pattern(regexp = "^(PDF|PNG|PPTX)$")
    private String format;
}
