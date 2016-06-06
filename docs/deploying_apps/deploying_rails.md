
For full details of how to deploy Ruby on Rails apps, see the official Cloud Foundry guide [Getting Started Deploying Ruby on Rails Apps](http://docs.cloudfoundry.org/buildpacks/ruby/gsg-ror.html). 

Note that the only database service currently supported by PaaS is PostgreSQL. If your Rails app requires a database, it must be able to work with PostgreSQL (this should be the case if the app follows the 12-factor principle of treating the database as a loosely-coupled backing service).

Here are the minimal steps for a basic Rails app:

1. Follow the setup instructions in [Getting Started](/overview/quick_start_guide/) and review [concepts](/overview/concepts/).  If you are just getting started learning CloudFoundry, you can use the sandbox space:

    ```
    cf target -o sandbox
    ```

1. [Exclude files ignored by Git](/deploying_apps/excluding_files/).
1. [Add the `rails_12factor` gem](https://github.com/heroku/rails_12factor#install) for better logging.
1. Create the application on Cloud Foundry.

    ```
    cf push <APP_NAME>
    ```

1. Set additional [environment variables](http://docs.run.pivotal.io/devguide/deploy-apps/environment-variable.html) required by your app. For example:
    ```
    cf set-env <APP_NAME> SECRET_TOKEN `rake secret`
    ```

1. If your app requires a database, [create a PostgreSQL backing service and bind it to your app](/deploying_services/postgres/).

Your app should now be live at `https://APP_NAME.cloudapps.digital`!

## Troubleshooting asset precompilation

By default, the Rails buildpack performs asset precompilation during the staging phase. This is fine for
most Rails apps, but it won't work for those which need to connect to services (such as the database)
during asset compilation. (For an example, see [MyUSA issue #636](https://github.com/18F/myusa/issues/636))

There are multiple potential solutions for this. For more advice, see
[the Cloud Foundry document on the subject](https://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html#precompile).