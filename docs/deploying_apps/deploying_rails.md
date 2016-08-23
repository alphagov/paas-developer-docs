
This section explains minimal steps for deploying a basic Rails app. For full details of how to deploy Ruby on Rails apps, see the official Cloud Foundry guide [Getting Started Deploying Ruby on Rails Apps](http://docs.cloudfoundry.org/buildpacks/ruby/gsg-ror.html). 


These steps assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.

When you deploy an app, you must select a combination of an organisation and a space (see [Orgs and spaces](/deploying_apps/orgs_spaces_targets) for more information). This is called the **target**.

We have provided a ``sandbox`` space for you to use for learning about the PaaS. You may want to target the sandbox while you are testing by running:

``cf target -s sandbox``

It's also important to realise that if you deploy an app using the same name and target as an existing app, the original will be replaced. If you are not sure about where to deploy your app, consult the rest of your team.

Note that the only database service currently supported by PaaS is PostgreSQL. If your Rails app requires a database, it must be able to work with PostgreSQL.

1. Check out your Rails app to a local folder.

1. [Exclude files ignored by Git](/deploying_apps/excluding_files/).

1. [Add the `rails_12factor` gem](https://github.com/heroku/rails_12factor#install) for better logging.

1. Create a manifest.yml file in the folder where you checked out your app.

        ---
        applications:
        - name: my-rails-app
          memory: 256M
          buildpack: ruby_buildpack

    Replace ``my-rails-app`` with a unique name for your app. (You can use ``cf apps`` to see apps which already exist).

    The `memory` line tells the PaaS how much memory to allocate to the app.

    A buildpack provides any framework and runtime support required by an app. In this case, because the app is written in Ruby, you use the ``ruby_buildpack``.

1. Set any additional [environment variables](//deploying_apps/#setting-environment-variables/) required by your app. For example:

    ```
    cf set-env APPNAME VARIABLE `value`
    ```

    where VARIABLE is a unique name for the variable, and `value` is the value to set.

1. If your app does not need a backing service like PostgreSQL, upload and start the application:

    ```
    cf push APPNAME
    ```

    from the folder where you checked out your app.

    If you do not specify a name for the app after the ``cf push`` command, the name from the manifest file is used.

    If your app needs a backing service, upload it but do not start it:

    ```
    cf push --no-start APPNAME
    ```

    [Create a PostgreSQL backing service and bind it to your app](/deploying_services/postgres/). 
    The Cloud Foundry buildpack for Ruby automatically gets the details of the first available PostgreSQL service from the ``VCAP_SERVICES`` environment variable and sets the Ruby DATABASE_URL accordingly.

    Once you have created and bound the PostgreSQL service, run:

    ```
    cf start APPNAME
    ```

Your app should now be live at `https://APPNAME.cloudapps.digital`!

For a production site, you should run at least two instances of the app to ensure availability.

You can add another instance of your app by running:

``cf scale APPNAME -i 2``

## Web servers

By default, the Cloud Foundry Ruby buildpack [runs `bin/rails server`](https://github.com/cloudfoundry/ruby-buildpack/blob/1f0ac3ce10866390d161c3f27e71d64890859454/lib/language_pack/rails4.rb#L27) 
to spin up the application. In Rails 4 and below, this will use WEBrick as the web
server. In Rails 5 and above, the default is
[puma](http://guides.rubyonrails.org/getting_started.html#starting-up-the-web-server).

You may want to use a different web server in production. See the Cloud Foundry docs for
[more information on configuring a production server](https://docs.cloudfoundry.org/buildpacks/prod-server.html) [external link].


## Troubleshooting asset precompilation

By default, the Rails buildpack performs asset precompilation during the staging phase. This is fine for
most Rails apps, but it won't work for those which need to connect to services (such as the database)
during asset compilation. (For an example, see [MyUSA issue #636](https://github.com/18F/myusa/issues/636))

There are multiple potential solutions for this. For more advice, see
[the Cloud Foundry document on the subject](https://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html#precompile).
