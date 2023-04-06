package containerapps.demo;

import org.springframework.web.bind.annotation.*;

import containerapps.demo.Rest.ServiceConnectionDownloadBodyDefinition;
import containerapps.demo.Rest.ServiceConnectionUploadBodyDefinition;

import java.util.List;
import java.util.ArrayList;
import org.springframework.http.HttpStatus;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@Tag(name = "Blob Storage Service Connections", description = "Blob Storage Service Connections API")
@RequestMapping("/api/serviceconnections/blobstorage")
public class BlobStorageServiceConnectionController {

    @GetMapping("/")
    @Operation(summary = "List Service Connections", description = "List all configured service connections to blob storage")
    @ResponseStatus(HttpStatus.OK)
    public List<String> listServiceConnections() {
        List<String> environments = new ArrayList<String>();
        // iterate over environment variables
        for (String envName : System.getenv().keySet()) {
            if (envName.startsWith("AZURE_STORAGEBLOB_") && ( envName.endsWith("_CONNECTIONSTRING") || envName.endsWith("_RESOURCEENDPOINT") )) {
                environments.add(envName);
            }
        }
        return environments;
    }

    @PostMapping("/upload")
    @Operation(summary = "Upload data to Service Connections", description = "Upload UTF8 string data to a blob storage service connections")
    @ResponseStatus(HttpStatus.OK)
    public boolean uploadStringToServiceConnection(@RequestBody ServiceConnectionUploadBodyDefinition destination) {
        return new AzureSDKStorage().setEnvironmentName(destination.serviceConnectionName).uploadFile(destination.containerName, destination.blobName, destination.blobContent);
    }

    @PostMapping("/download")
    @Operation(summary = "Download data from Service Connections", description = "Upload UTF8 string data to a blob storage service connections")
    @ResponseStatus(HttpStatus.OK)
    public String downloadStringFromServiceConnection(@RequestBody ServiceConnectionDownloadBodyDefinition destination) {
        return new AzureSDKStorage().setEnvironmentName(destination.serviceConnectionName).downloadFile(destination.containerName, destination.blobName);
    }

}

