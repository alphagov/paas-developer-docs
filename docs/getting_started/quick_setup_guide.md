## Getting an account
Government PaaS is currently in private beta and aims to host its first applications in June 2016.

If you are part of the private beta but don't have an account or if you’d like to be one of the early applications in the future, please contact us by emailing [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).

## Setting up the command line
Government PaaS uses a hosting technology called Cloud Foundry. As a tenant, nearly all of your interactions with Government PaaS will be through the Cloud Foundry command line client. To get it set up:

1. [Install the Cloud Foundry CLI](https://docs.cloudfoundry.org/devguide/installcf/install-go-cli.html).
2. To check the installation, run:

    ```
    cf -v
    ```

    *Note:* depending on your network configuration you might need to [set an ```HTTP_PROXY``` environment variable](https://docs.cloudfoundry.org/cf-cli/http-proxy.html) for the CLI to connect. Contact your network administrators to work out the correct settings for your configuration.  

3. Log in by running:

    ```
    cf login -a api.cloud.service.gov.uk -u USERNAME
    ```

    Your `USERNAME` is your email address your account was created with.

    You will then be prompted to enter your password, which should have been sent to you by email (subject "Welcome to the Government PaaS").

Once logged in, you can see the available commands by running ```cf```.

For security, you should change your password using ``cf passwd``.

## Organisations and spaces

Your tenant account belongs to one or more organisations ("orgs" for short). Orgs group together CF users for management and present a shared perimeter for services, domains and quotas.

To list available orgs, run:

``cf orgs``

To see details about an org, run:

``cf org ORGNAME``

where ORGNAME is the name of the org.

Each org contains one or more spaces. Applications in the same space share a location for app development, deployment, and maintenance.

To see the spaces in your current org, run:

``cf spaces``

The Cloud Foundry CLI keeps a global state of the organisation and space you're currently interacting with. This is known as the "target", and is set via:

``cf target -o ORGNAME -s SPACENAME``

You will need to set a target before you deploy your app.

## Deploying a test app
To practice deploying an app, try following the [deploying a static site](/deploying_apps/deploying_static_sites/) process.

While you are learning to use the Cloud Foundry CLI, you may want to target the sandbox space when you deploy any test apps:

``cf target -s sandbox``
