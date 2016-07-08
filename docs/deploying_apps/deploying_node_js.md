This section covers how to deploy a basic Node.js application to Government PaaS. See the Cloud Foundry [Tips for Node.js Applications](http://docs.cloudfoundry.org/buildpacks/node/node-tips.html) for more details.

Note that the only database service currently supported by PaaS is PostgreSQL. If your Node.js app requires a database, it must be able to work with PostgreSQL.

These instructions assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.

This is the code for the example app we are going to use. It is a basic web server that responds with a 'Hello World' message.

    const http = require('http');

    const port = process.env.PORT || 3000;

    const server = http.createServer((req, res) => {
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/plain');
      res.end('Hello World\n');
    });

    server.listen(port, () => {
      console.log(`Server running on ${port}/`);
    });

1. Save the code to a new local directory as ``example.js``.
1. Add this ``manifest.yml`` file to the same directory:

        ---
        applications:
        - name: my-node-app
          command: node example.js
          memory: 256M
          buildpack: nodejs_buildpack

    The ``name`` value sets the name for the app within the Government PaaS. You'll use this name to apply further Cloud Foundry commands to the app: for example, if you want to stop it.

    The ``command`` value is the command that will be used to start the app after it is uploaded. Make sure that the filename used in the command matches the filename you used to save your app in the previous step.

    The ``memory`` value specifies how much memory will be allocated to the app.

    A buildpack provides the framework and runtime support required by an app. In this case, we specify ``nodejs_buildpack`` because we're using a Node.js app.

    See [Deploying with Application Manifests](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html) on the Cloud Foundry site for more details about what you can specify in the manifest file.

1. Create an npm ``package.json`` file in the same directory. 
  
    This is a ``package.json`` file for our example app:

        {
          "name": "example",
          "version": "0.0.1",
          "author": "Demo",
          "engines": {
            "node": "6.1.0",
            "npm": "2.7.4"
          }
        }

    The ``"engines"`` values specify the versions of Node.js and npm that the PaaS should use to run your app. Note that older versions may not be available: if your version is not supported, you will see an error message when you try to upload and start the app.

1. You can optionally run `npm install` to preinstall dependencies rather than having them added during the PaaS staging process.
1. Run `cf push` to upload and start the app.

Please refer to [Tips for Node.js Applications](https://docs.cloudfoundry.org/buildpacks/node/node-tips.html) in the Cloud Foundry documentation for further information.


##Node.js and backing services

If your app depends on [backing services](/deploying_services/) such as PostgreSQL, it will need to parse the `VCAP_SERVICES` environment variable to get required details, such as service URLs and credentials.

You must create the service and bind it to your Node.js app as described in the [Deploying Services](/deploying_services/) section.

You can use the [cfenv](https://www.npmjs.com/package/cfenv) module to assist with parsing the environment variables.

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

