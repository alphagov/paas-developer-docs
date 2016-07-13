
## Deploying Docker images is not currently enabled

Cloud Foundry supports pushing a [Docker](https://www.docker.com/) image as an app. 

This feature is *not* currently enabled on the Government PaaS because allowing deployment from Docker images, where the root filesystem is controlled by the tenant, raises additional security concerns: see [this note from the CF developers](https://github.com/cloudfoundry/diego-design-notes/blob/c59e475020a22e244c6074f89c45b55f7b1e2867/docker-support.md#docker-in-a-multi-tenant-world) for more details.

We may enable support for Docker images in the future. If you would like to be able to push Docker images, please contact our support team at [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk), providing details of your use case.