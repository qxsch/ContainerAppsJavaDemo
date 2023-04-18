package containerapps.demo;


import org.springframework.web.bind.annotation.*;

import containerapps.demo.Rest.DaprDownloadBodyDefinition;
import containerapps.demo.Rest.DaprUploadBodyDefinition;

import java.util.List;
import java.util.ArrayList;
import org.springframework.http.HttpStatus;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;


@RestController
@Tag(name = "Blob Storage DAPR Integration", description = "Blob Storage DAPR Integration API")
@RequestMapping("/api/dapr/blobstorage")
public class BlobStorageDaprController {
    /*
    @GetMapping("/")
    @Operation(summary = "List DAPR Integrations", description = "List all configured DAPR integrations to blob storage")
    @ResponseStatus(HttpStatus.OK)
    public List<String> listServiceConnections() {
        List<String> environments = new ArrayList<String>();

        try(DaprClient client = (new DaprClientBuilder()).build()) {
            client.invokeBinding("BINDING_NAME", "BINDING_OPERATION", "JSON-Data").block();
        }
        catch(Exception e) {
            System.out.println(e.getMessage());
        }

        // iterate over environment variables
        for (String envName : System.getenv().keySet()) {
            if (envName.startsWith("AZURE_STORAGEBLOB_") && ( envName.endsWith("_CONNECTIONSTRING") || envName.endsWith("_RESOURCEENDPOINT") )) {
                environments.add(envName);
            }
        }
        return environments;
    } 
    */

    @PostMapping("/upload")
    @Operation(summary = "Upload data to DAPR Integration", description = "Upload UTF8 string data to a blob storage DAPR integration")
    @ResponseStatus(HttpStatus.OK)
    public boolean uploadStringToServiceConnection(@RequestBody DaprUploadBodyDefinition destination) {
        return new DaprStorage().setEnvironmentName(destination.daprComponentName).uploadFile(destination.blobName, destination.blobContent);
    }

    @PostMapping("/download")
    @Operation(summary = "Download data from DAPR Integration", description = "Upload UTF8 string data to a blob storage DAPR integration")
    @ResponseStatus(HttpStatus.OK)
    public String downloadStringFromServiceConnection(@RequestBody DaprDownloadBodyDefinition destination) {
        return new DaprStorage().setEnvironmentName(destination.daprComponentName).downloadFile(destination.blobName);
    }
}
