This section explains how to create and deploy a static HTML page. It's
worth testing that you can carry out this process before you try to deploy a dynamic app.

These steps assume you have already carried out the setup process explained in the [Quick Setup Guide](/getting_started/quick_setup_guide) section.

1. Create `index.html`:

    ``
    touch index.html
    ``

2. Add some markup to the `index.html` file:

    
        <html>
          <head>
            <title>Static Site</title>
          </head>
          <body>
            <p>Welcome to the static site!</p>
          </body>
        </html>
    

3. Create a `manifest.yml` which uses the [`staticfile_buildpack`](https://github.com/cloudfoundry/staticfile-buildpack):

        ---
        applications:
        - name: my-static-site
        memory: 64M
        buildpack: staticfile_buildpack
    
    Replace ``my-static-site`` with a unique name for your app.

    If the app name is not unique, you will get an error like this:

        Server error, status code: 400, error code: 210003, message: The host is taken: taken_name

    You can use ``cf apps`` to see the apps which are already running.

    If the static content is included in a different folder, you can add a `path` declaration, e.g. `path: dist` or `path: assets`.

4. From the directory where the `manifest.yml` file is, run:

    ``
    cf push
    ``
    
    If you do not specify an app name with the ``push`` command, the name  specified in the manifest file is used.

The site should now be live at `https://APPNAME.cloudapps.digital`.

For a production site, you should run at least two instances of the app to ensure availability.

You can add another instance of this static app by running:

``cf scale APPNAME -i 2``

