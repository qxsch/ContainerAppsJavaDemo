package containerapps.demo.Rest;

import io.swagger.v3.oas.annotations.media.Schema;

public class DaprUploadBodyDefinition {
    @Schema(description = "The DAPR component name to the blob storage integration", example = "mystoragecontainer")
    public String daprComponentName;

    @Schema(description = "The full path to the blob", example = "path/to/myblob.txt")
    public String blobName;

    @Schema(description = "The UTF8 content of the blob", example = "hello world")
    public String blobContent;
}
