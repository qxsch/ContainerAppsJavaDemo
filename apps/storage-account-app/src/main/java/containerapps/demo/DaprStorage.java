package containerapps.demo;

import java.util.*;
import java.util.logging.Logger;
import io.dapr.client.DaprClient;
import io.dapr.client.DaprClientBuilder;
import io.dapr.client.domain.State;

public class DaprStorage {
    private static final Logger log;
    private String environmentName = null;

    static {
        System.setProperty("java.util.logging.SimpleFormatter.format", "[%4$-7s] %5$s %n");
        log = Logger.getLogger(AzureSDKStorage.class.getName());
    }

    public String getEnvironmentName() {
        return this.environmentName;
    }
    public DaprStorage setEnvironmentName(String name) {
        this.environmentName = name;
        return this;
    }


    protected DaprClient getDaprClient() throws IllegalStateException {
        return (new DaprClientBuilder()).build();
    }

    public String downloadFile(String blobName) {
        try {
            DaprClient client = this.getDaprClient();
            State<String> content = client.getState(this.environmentName, blobName, String.class).block();
            return content.getValue();
        }
        catch(Exception e) {
            log.severe(e.getMessage());
            return null;
        }
    }

    public boolean uploadFile(String blobName, String value) {
        try {
            DaprClient client = this.getDaprClient();
            client.saveState(this.environmentName, blobName, value).block();
            return true;
        }
        catch(Exception e) {
            log.severe(e.getMessage());
            return false;
        }
    }
}
