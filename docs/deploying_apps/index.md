## Deployment overview

The `cf push` command is used both to create a new app and to push a new version of an existing one. The basic steps:

1. Check out whatever version of the code you want to deploy.
    ```
    git checkout master
    ```

1. Target the appropriate organisation and space.
    ```
    cf target -o <SOMEORG> -s <SOMESPACE>
    ```
1. Deploy the application by running:

    ```
    cf push <APPNAME>
    ```

    from the directory where you checked out the code.

The app should now be live at `https://APPNAME.cloudapps.digital`.

## Caveats
* Your app should not write to local storage: it's ephemeral and can be deleted at any time.
* Instances will be restarted if they [exceed memory limits](/deploying_apps/quotas/).
* Proper [logging](/deploying_apps/logging/) might require special libraries/configuration for your app.

## Setting environment variables

See Cloud Foundry's [documentation on environment variables](https://docs.cloudfoundry.org/devguide/deploy-apps/environment-variable.html).