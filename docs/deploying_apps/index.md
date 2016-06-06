## Deployment overview

The `cf push` command is used both to create a new app and to push a new version of an existing one. The basic steps:

1. Check out whatever version of the code you want to deploy from version control.

    ```
    git checkout master
    ```


1. Target the appropriate organisation and space.
    ```
    cf target -o SOMEORG -s SOMESPACE
    ```
1. Deploy the application by running:

    ```
    cf push APPNAME
    ```

    from the directory where you checked out the code.

The app should now be live at `https://APPNAME.cloudapps.digital`.

For a production app, you should run at least two instances to improve availability.

Increase the running instances to two using:

``cf scale APPNAME -i 2``

## Caveats
* Your app should not write to local storage. Cloud Foundry local storage is ephemeral and can be deleted at any time.
* Instances will be restarted if they [exceed memory limits](/managing_apps/quotas/).
* Proper [logging](/deploying_apps/logging/) might require special libraries/configuration for your app.

## Setting environment variables

All the configuration information for your app (for example, credentials for external services, or values that vary between each deployment such as canonical hostname) must be stored in environment variables, not in the code.

To view current environment variables, run:

``cf env APPNAME``

To set a new variable, use:

``cf set-env APPNAME``

For more details, see Cloud Foundry's [documentation on environment variables](https://docs.cloudfoundry.org/devguide/deploy-apps/environment-variable.html).