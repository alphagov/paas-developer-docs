## Getting an account.
PaaS is currently in private beta and aims to host its first applications in May 2016.

If you are part of the private beta but don't have an account or if you’d like to be one of the early applications in the future, please contact us by emailing [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).

## Setting up the command line
As a user, nearly all of your interactions with Cloud Foundry will be through the command line. To get it set up:

1. [Install the CLI](https://docs.cloudfoundry.org/devguide/installcf/install-go-cli.html).
2. Confirm the installation by running

    ```
    cf -v
    ```

*Note:* depending on your network configuration you might need to set an ```HTTP_PROXY``` environment variable for the CLI to connect. Contact your network administrators to work out the correct settings for your configuration.

3. Log in by running

    ```
    cf login -a api.cloud.service.gov.uk -u USERNAME
    ```

Your `USERNAME` is your email address your account was created with.

## CF CLI
Once logged in you can see commands available by running ```cf```.

## Deploying Apps
To practice deploying an app try following the [deploying static apps](/deploying_apps/deploying_static_sites/) process.