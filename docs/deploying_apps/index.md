## How deployment works

The command to create a new app and to push a new version of an existing one are the same: `cf push`


The basic steps:

1. Check out the version of the code you want to deploy:
    ```
    git checkout master
    ```

1. [Target](/overview/concepts/#target) the appropriate [organisation](/overview/concepts/#organisations)/[space](/overview/concepts/#spaces):
    ```
    cf target -o <SOMEORG> -s <SOMESPACE>
    ```
1. Deploy the application:
    ```
    cf push <APPNAME>
    ```

The app should now be live at `APPNAME.cloudapps.digital`.

## Caveats
* Don't write to local storage (it's ephemeral)
* Instances will be restarted if they [exceed memory limits](/deploying_apps/quotas/)
* Proper [logging](/deploying_apps/logging/) might require special libraries/configuration for your app

## Setting environment variables

See Cloud Foundry's [documentation on environment variables](https://docs.cloudfoundry.org/devguide/deploy-apps/environment-variable.html).