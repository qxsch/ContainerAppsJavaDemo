package containerapps.demo.Rest;

import io.swagger.v3.oas.annotations.media.Schema;

public class ServiceConnectionDownloadBodyDefinition {
    @Schema(description = "The service connection name to the blob storage", example = "AZURE_STORAGEBLOB_CONNECTIONSTRING")
    public String serviceConnectionName;
    
    @Schema(description = "The name of the blob container", example = "default")
    public String containerName;

    @Schema(description = "The full path to the blob", example = "path/to/myblob.txt")
    public String blobName;
}
