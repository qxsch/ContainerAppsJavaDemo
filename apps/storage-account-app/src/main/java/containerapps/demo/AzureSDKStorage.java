package containerapps.demo;

import java.util.*;
import java.util.logging.Logger;
import java.time.Duration;
// import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import com.azure.core.util.BinaryData;
import com.azure.core.http.rest.Response;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobClientBuilder;
import com.azure.storage.blob.options.BlobParallelUploadOptions;
import com.azure.storage.blob.models.BlobDownloadContentResponse;
import com.azure.storage.blob.models.DownloadRetryOptions;
import com.azure.storage.blob.models.BlobRequestConditions;
import com.azure.storage.blob.models.BlockBlobItem;
import com.azure.storage.blob.models.BlobHttpHeaders;

public class AzureSDKStorage {
    private static final Logger log;
    private String environmentName = null;

    static {
        System.setProperty("java.util.logging.SimpleFormatter.format", "[%4$-7s] %5$s %n");
        log = Logger.getLogger(AzureSDKStorage.class.getName());
    }

    public String getEnvironmentName() {
        return this.environmentName;
    }
    public AzureSDKStorage setEnvironmentName(String name) {
        this.environmentName = name;
        return this;
    }

    protected BlobClient getBlobClient(String  containerName, String blobName) throws RuntimeException {
        if(this.environmentName == null) {
            throw new RuntimeException("EnvironmentName is not set");
        }

        String enviornmentValue = System.getenv(this.environmentName);
        if(enviornmentValue == null || enviornmentValue == "") {
            throw new RuntimeException("EnvironmentName \"" + environmentName + "\" is not set");
        }

        if(this.environmentName.startsWith("AZURE_STORAGEBLOB_")) {
            if(this.environmentName.endsWith("_CONNECTIONSTRING")) {
                return new BlobClientBuilder()
                .connectionString(enviornmentValue)
                .containerName(containerName)
                .blobName(blobName)
                .buildClient();
            }
            else if(this.environmentName.endsWith("_RESOURCEENDPOINT")) {
                return new BlobClientBuilder()
                .endpoint(enviornmentValue)
                .containerName(containerName)
                .blobName(blobName)
                .credential(new DefaultAzureCredentialBuilder().build())
                .buildClient();
            }
        }

        throw new RuntimeException("EnvironmentName \"" + environmentName + "\" is not supported.");
    }

    public String downloadFile(String containerName, String blobName) {
        BlobClient blobClient = this.getBlobClient(containerName, blobName);

        // create empty conditions
        BlobRequestConditions requestConditions = new BlobRequestConditions();

        Duration REST_UPLOAD_TIMEOUT = Duration.ofMinutes(2);

        BlobDownloadContentResponse contentResponse = blobClient.downloadContentWithResponse(
            new DownloadRetryOptions()
            .setMaxRetryRequests(10),
            requestConditions, 
            REST_UPLOAD_TIMEOUT,
            null
        );
        if(contentResponse.getStatusCode() != 200) {
            log.info("Download from file failed: " + contentResponse.getStatusCode());
            return null;
        }
        log.info("Download from file succeeded: " + contentResponse.getStatusCode());
        BinaryData content = contentResponse.getValue();
        if(content == null) {
            return null;
        }
        return content.toString();
    }

    public boolean uploadFile(String containerName, String blobName, String value) {
        BlobClient blobClient = this.getBlobClient(containerName, blobName);

        // Path HTTP Headers
        BlobHttpHeaders headers = new BlobHttpHeaders()
            .setContentLanguage("en-US")
            .setContentType("binary");

        // metadata
        Map<String, String> metadata = Collections.singletonMap("metadata", "value");

        // create empty conditions
        BlobRequestConditions requestConditions = new BlobRequestConditions();

        Duration REST_UPLOAD_TIMEOUT = Duration.ofMinutes(2);

        Long MAX_BLOCK_SIZE = 100L * 1024L * 1024L; // 100 MB;
        com.azure.storage.blob.models.ParallelTransferOptions parallelTransferOptions = new com.azure.storage.blob.models.ParallelTransferOptions()
            .setBlockSizeLong(MAX_BLOCK_SIZE);

        // generate an inputstram from string
        InputStream is = new java.io.ByteArrayInputStream(value.getBytes(java.nio.charset.StandardCharsets.UTF_8));
        try {
            Response<BlockBlobItem> pi = blobClient.uploadWithResponse(new BlobParallelUploadOptions(is)
                .setParallelTransferOptions(parallelTransferOptions)
                .setHeaders(headers)
                .setMetadata(metadata)
                .setRequestConditions(requestConditions), 
                REST_UPLOAD_TIMEOUT,
                null
            );
            log.info("Upload from file succeeded: " + pi.getRequest().getUrl());
        } catch (UncheckedIOException ex) {
            log.severe("Failed to upload: " + ex.getMessage());
            return false;
        }
        try {
            is.close();
        } catch (IOException ex) {
            log.severe("Failed to close input stream: " + ex.getMessage());
            return false;
        }

        return true;
    }
}
