
For full details of how to deploy Ruby on Rails apps, see the official Cloud Foundry guide [Getting Started Deploying Ruby on Rails Apps](http://docs.cloudfoundry.org/buildpacks/ruby/gsg-ror.html). 

Note that the only database service currently supported by PaaS is PostgreSQL. If your Rails app requires a database, it must be able to work with PostgreSQL.

This section explains minimal steps for deploying a basic Rails app.

These steps assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.

If you are just getting started learning CloudFoundry, you can use the sandbox space:

``cf target -o sandbox``

1. Check out your Rails app to a local folder.
1. [Exclude files ignored by Git](/deploying_apps/excluding_files/).
1. [Add the `rails_12factor` gem](https://github.com/heroku/rails_12factor#install) for better logging.
1. Create a manifest.yml file in the folder where you checked out your app.

        ---
        applications:
        - name: my-rails-app
          memory: 256M
          buildpack: ruby_buildpack


1. Create the application using Cloud Foundry:

    ```
    cf push  
    ```

    from the folder where you checked out your app.

    If you do not specify a name for the app after the ``cf push`` command, the name from the manifest file is used.

1. Set any additional [environment variables](//deploying_apps/#setting-environment-variables/) required by your app. For example:

    ```
    cf set-env APPNAME VARIABLE `value`
    ```

    where VARIABLE is a unique name for the variable, and `value` is the value to set.

1. If your app requires a database, [create a PostgreSQL backing service and bind it to your app](/deploying_services/postgres/). 

Your app should now be live at `https://APPNAME.cloudapps.digital`!

For a production site, you should run at least two instances of the app to ensure availability.

You can add another instance of your app by running:

``cf scale APPNAME -i 2``

## Troubleshooting asset precompilation

By default, the Rails buildpack performs asset precompilation during the staging phase. This is fine for
most Rails apps, but it won't work for those which need to connect to services (such as the database)
during asset compilation. (For an example, see [MyUSA issue #636](https://github.com/18F/myusa/issues/636))

There are multiple potential solutions for this. For more advice, see
[the Cloud Foundry document on the subject](https://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html#precompile).