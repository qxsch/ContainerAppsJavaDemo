package containerapps.demo;


import org.springframework.web.bind.annotation.*;

import containerapps.demo.Rest.DaprDownloadBodyDefinition;
import containerapps.demo.Rest.DaprUploadBodyDefinition;

import org.springframework.http.HttpStatus;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;


@RestController
@Tag(name = "Blob Storage DAPR Integration", description = "Blob Storage DAPR Integration API")
@RequestMapping("/api/dapr/blobstorage")
public class BlobStorageDaprController {
    @PostMapping("/upload")
    @Operation(summary = "Upload data to DAPR Integration", description = "Upload UTF8 string data to a blob storage DAPR state integration")
    @ResponseStatus(HttpStatus.OK)
    public boolean uploadStringToServiceConnection(@RequestBody DaprUploadBodyDefinition destination) {
        return new DaprStorage().setEnvironmentName(destination.daprComponentName).uploadFile(destination.blobName, destination.blobContent);
    }

    @PostMapping("/download")
    @Operation(summary = "Download data from DAPR Integration", description = "Upload UTF8 string data to a blob storage DAPR state integration")
    @ResponseStatus(HttpStatus.OK)
    public String downloadStringFromServiceConnection(@RequestBody DaprDownloadBodyDefinition destination) {
        return new DaprStorage().setEnvironmentName(destination.daprComponentName).downloadFile(destination.blobName);
    }
}
