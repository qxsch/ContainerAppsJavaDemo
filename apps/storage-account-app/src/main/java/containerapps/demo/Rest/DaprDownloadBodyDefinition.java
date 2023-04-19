package containerapps.demo.Rest;

import io.swagger.v3.oas.annotations.media.Schema;

public class DaprDownloadBodyDefinition {
    @Schema(description = "The DAPR component name to the blob storage integration", example = "mystoragecontainer")
    public String daprComponentName;

    @Schema(description = "The full path to the blob", example = "path/to/myblob.txt")
    public String blobName;
}
