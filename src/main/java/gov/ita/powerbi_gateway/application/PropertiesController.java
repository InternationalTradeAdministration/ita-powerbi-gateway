package gov.ita.powerbi_gateway.application;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PropertiesController {

    @Autowired
    private ServerProperties serverProperties;

    @GetMapping("/application/server/properties")
    public String getServerProperties() {
        return "maxHttpHeaderSize: " + serverProperties.getMaxHttpHeaderSize();
    }
}
