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

There are many options available when you ``push`` an app. You can optionally set them in a ``manifest.yml`` file in the directory from which you are running the ``push`` command. See the Cloud Foundry documentation on [Deploying with Application Manifests](http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html) for details.

For a production app, you should run at least two instances to ensure availability.

Increase the running instances to two using:

``cf scale APPNAME -i 2``

## Caveats
* Your app should not write to local storage. Cloud Foundry local storage is ephemeral and can be deleted at any time.
* Instances will be restarted if they [exceed memory limits](/managing_apps/quotas/).
* Proper [logging](/deploying_apps/logging/) might require special libraries/configuration for your app.

## Environment variables

All the configuration information for your app (for example, credentials for external services, or values that vary between each deployment such as canonical hostname) must be stored in environment variables, not in the code.

There are two system-provided environment variables:

* VCAP_SERVICES which provides details of any available backing services, such as PostgreSQL.
* VCAP_APPLICATION which provides details of the currently running application.

You can also create your own variables.

To view an app's current environment variables, run:

``cf env APPNAME``

To set a new variable, use:

``cf set-env APPNAME``

For more details, see Cloud Foundry's [documentation on environment variables](https://docs.cloudfoundry.org/devguide/deploy-apps/environment-variable.html).