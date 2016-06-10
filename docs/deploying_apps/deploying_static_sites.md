This section explains how to create and deploy a static HTML page. It's
worth testing that you can carry out this process before you try to deploy a dynamic app.

These steps assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.

1. Create a folder for your static site with an `index.html` file inside it.

2. Add some markup to the `index.html` file:

    
        <html>
          <head>
            <title>Static Site</title>
          </head>
          <body>
            <p>Welcome to the static site!</p>
          </body>
        </html>

3. In the same folder, add a `manifest.yml` file which tells Cloud Foundry to use the [buildpack for static files](https://github.com/cloudfoundry/staticfile-buildpack):

        ---
        applications:
        - name: my-static-site
        memory: 64M
        buildpack: staticfile_buildpack
        

    Replace ``my-static-site`` with a unique name for your app.

    If the app name is not unique, you will get an error like this:

        Server error, status code: 400, error code: 210003, message: The host is taken: taken_name

    You can use ``cf apps`` to see the apps which are already running.

4. From the directory where the `manifest.yml` file is, run:

    ``
    cf push
    ``
    
    If you do not specify an app name after the ``push`` command, the name  specified in the manifest file is used.

The site should now be live at `https://APPNAME.cloudapps.digital`.

Note that if the static content you want to serve is in a different folder to `manifest.yml`, you can add a `path` declaration to `manifest.yml` e.g. `path: dist` or `path: /site/assets`.

##Adding more instances

For a production site, you should always run at least two instances of the app to ensure availability. 

After deploying, you can add another instance of the static site app by running:

``cf scale APPNAME -i 2``

Instead of adding another instance after deployment, you might prefer to always have two instances when the app is deployed with ``cf push``. 

You can do that by adding the `instances` attribute at the bottom of the ``manifest.yml`` file:

        ---
          ...
          instances: 2


You may have noticed that the manifest file also tells Cloud Foundry how much memory to assign to the static site app (64MB in this example). 

See [Deploying with Application Manifests](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html) in the Cloud foundry documentation for more details of what you can specify in the manifest file.


