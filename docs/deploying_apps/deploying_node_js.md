This section covers how to deploy a basic Node.js application to Government PaaS. See the Cloud Foundry [Tips for Node.js Applications](http://docs.cloudfoundry.org/buildpacks/node/node-tips.html) for more details.

Note that the only database service currently supported by PaaS is PostgreSQL. If your Node.js app requires a database, it must be able to work with PostgreSQL.

Your app will need to parse the ``VCAP_SERVICES`` environment variable to get details of any backing services, such as PostgreSQL. See the section [Node.js and backing services](#nodejs-and-backing-services) below.

These steps assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.


1. Check out your Node.js app to a local folder.
2. [Exclude files ignored by Git](/deploying_apps/excluding_files/).
3. Create a ``manifest.yml`` file:

        ---
        applications:
        - name: my-node-app
          memory: 256M
          buildpack: nodejs_buildpack

3. Include an npm ``package.json`` file to specify dependencies. The file should also specify a `start` command used to launch the app.
  
    This is an example of a minimal ``package.json`` file:

        
        {
          "name": "my-node-app",
          "version": "0.0.1",
          "author": "Demo",
          "scripts": {
            "start": "node my-node-app.js"
          }
        }

    Note that you can use a ``command:`` key in ``manifest.yml`` to specify the command to start your application, but this is not recommended because the functionality [may be removed](https://github.com/cloudfoundry/nodejs-buildpack/pull/11#issuecomment-67666273). 

4. Ensure the app listens on the Cloud Foundry assigned port by using the [cfenv](https://www.npmjs.com/package/cfenv) module to retrieve information from the ``VCAP_APPLICATION`` environment variable.


        var cfenv = require("cfenv");
        var appEnv = cfenv.getAppEnv();
        config.app.port = appEnv.port;


5. You can optionally run `npm install` prior to `cf push` to preinstall dependencies rather than having them added during staging.


##Node.js and backing services

If your app depends on [backing services](/deploying_services/) such as PostgreSQL, it will need to parse the `VCAP_SERVICES` environment variable to get required details, such as service URLs and credentials.

You must create the service and bind it to your Node.js app as described in the [Deploying Services](/deploying_services/) section.

We recommend you use the [cfenv](https://www.npmjs.com/package/cfenv) module to assist with parsing the environment variables.

In your ``package.json`` file, you would specify ``cfenv`` as a dependency:

        {
          // ...
          "dependencies": {
            "cfenv": "*",
            // ...
          }
        }
    

Then in your app, you can easily get configuration information for backing services. This is an example of how to connect to a PostgreSQL service.

        var cfenv = require("cfenv");
        var appEnv = cfenv.getAppEnv();
        var connectionString = appEnv.getServiceURL("my-postgres");
        var client = new pg.Client(connectionString);
        client.connect();
  

Note that in the above you should replace "my-postgres" with the exact name of the PostgreSQL service you created. The ``getServiceURL`` function returns a connection string which includes the username and password required to connect to the database.

You should also remember to include dependencies for any service bindings in ``package.json``.

    ```
    {
      // ...
      "dependencies": {
        "pg": "*",
        // ...
      }
    }
    ```

