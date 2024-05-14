# ContainerAppsJavaDemo 🪺

This demo aims to be a paved road for anyone who would like to start using ACA with Java-based workloads. The demo demonstrates how to seamlessly deploy infrastructure dependencies, such as storage accounts, alongside an app's infrastructure deployment. Those dependencies are then available during the runtime. On container apps, there are two options for this, Dapr and service connections. Both options are covered by this demo.

## Repository Structure

- `/.github/workflows/build-and-push-docker-image.yml`: The pipeline for Docker build
- `/.github/workflows/deploy.yml`: The deploy pipeline (still in development)
- `/apps/storage-account-app`: A sample Java-based Spring Boot demo application
- `/modules`: Directory containing Terraform modules for deploying the application
- `/environments`: Directory containing concrete usage of the modules for different environments (only dev for the demo scope)

## Terraform

- `/environments/dev/acr`: Demo usage of the ACR module
- `/environments/dev/storage-account-app`: Demo usage of the Container App module

## Deployment

Terraform is used to deploy the application. Follow these steps to deploy the ContainerAppsJavaDemo:

1. Install [Terraform](https://www.terraform.io/downloads.html) on your machine
2. Navigate to the `/environments/dev` directory
3. Navigate to the sub directory you want to deploy (e.g. `storage-account-app`)
4. Review and update the module configuration in `main.tf`
5. Run `terraform init` to initialize the Terraform backend and download the required providers
6. Run `terraform plan` to review the changes that will be applied
7. Run `terraform apply` to apply the changes and deploy the infrastructure
8. After deployment is complete, you can access the storage-account-app APIs using the generated endpoint

## Storage Account Demo App

The `/apps/storage-account-app` is a Spring Boot application that exposes APIs for demonstrating both accessing a storage account via Dapr and via service connection.

### Blob Storage Service Connections API

- `POST /api/serviceconnections/blobstorage/upload`: Upload a UTF-8 string data to a blob storage service connection.
- `POST /api/serviceconnections/blobstorage/download`: Download a UTF-8 string data from a blob storage service connection.
- `GET /api/serviceconnections/blobstorage/`: List all configured service connections to blob storage.


### Blob Storage Dapr Integration API

- `POST /api/dapr/blobstorage/upload`: Upload a UTF-8 string data to a blob storage Dapr state integration.
- `POST /api/dapr/blobstorage/download`: Download a UTF-8 string data from a blob storage Dapr state integration.
