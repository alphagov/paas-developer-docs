## Environment variables

All the configuration information for your app must be stored as environment variables, not in the code. 

This includes credentials for external services that your app uses, such as a Twitter account, as well as values that will vary with each deployment of the app, like the canonical URL.

To view an app's current environment variables, run:

``cf env APPNAME``

To create or update a variable, use:

``cf set-env APPNAME ENV_VAR_NAME ENV_VAR_VALUE``

If you're deploying a pre-existing app that was written with 12-factor in mind, check the app's documentation for any environment variables you need to set.

If the app has instructions to deploy to Heroku, and tells you to do something like:

``heroku config:set VARIABLE=value``

then you should do the equivalent command with ``cf set-env``:

``cf set-env APPNAME VARIABLE value``

###System-provided environment variables

There are two system-provided environment variables:

* VCAP_SERVICES which provides details of any available backing services, such as PostgreSQL, in JSON format.
* VCAP_APPLICATION which provides details of the currently running application (for example, language runtime version) in JSON format.

If you app connects to a backing service, you may need to make it parse VCAP_SERVICES to get the credentials and other settings relating to that service.

However, some buildpacks will handle this automatically. See the deploy instructions for the language/framework you are using for details.

###Further reading

For more information, see Cloud Foundry's [Cloud Foundry Environment Variables](https://docs.cloudfoundry.org/devguide/deploy-apps/environment-variable.html) documentation.