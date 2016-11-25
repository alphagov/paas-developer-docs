# Pushing an app to Cloud Foundry using Jenkins

This documentation covers two main approaches to pushing applications to Cloud Foundry within Jenkins:

1. Use the Cloud Foundry plugin
1. Custom scripts

Our documentation for both of these approaches requires you to add your Cloud Foundry username and password into Jenkins using the Credentials Plugin. Follow the instructions on '[Using the Credentials Plugin](/deploying_apps/jenkins/#using-the-credentials-plugin)' to set this up. You should use a separate user intended for use only from Jenkins and scoped to a specific Cloud Foundry space.

The first approach is the most basic and consists of taking your repository and pushing it to Cloud Foundry. It is the equivalent to doing a `cf login` followed by a `cf push`. There is little scope for configuration beyond what is covered by the application manifest. To use the plugin follow the '[Installing the Cloud Foundry Plugin](/deploying_apps/jenkins/#installing-the-cloud-foundry-plugin)' instructions.

The second approach allows you to fully script your deployment. To do this securely you will need to follow the '[Installing the Credentials Binding Plugin](/deploying_apps/jenkins/#installing-the-credentials-binding-plugin)' instructions to make credentials available as environment variables.

## Using the Credentials Plugin

**Note:** This plugin may be already bundled with Jenkins versions before 2.0.

To install:

* In Jenkins click on 'Manage Jenkins', then 'Manage Plugins'.
* Click on the 'Available' tab and find the Credentials Plugin. Tick the box to select the plugin, then click the button to download and install the plugin.

Once installed you should have a 'Credentials' link in the main menu. Now you can add credentials for the Cloud Foundry you will be using for pushing apps within Jenkins:

* Click on 'Credentials', then 'System'. You will have a 'Global credentials' domain by default.
* You should set up different domains to segregate different Cloud Foundry environments (users).
* Click 'Add domain', enter the details, and then click 'Ok'. You should be presented with a link to add some credentials.
* Add your Cloud Foundry user's credentials. The kind of credentials is 'Username with password', which is typically selected by default.

## Installing the Cloud Foundry Plugin

* In Jenkins click on 'Manage Jenkins', then 'Manage Plugins'.
* Click on the 'Available' tab and find the Cloud Foundry Plugin. Tick the box to select the plugin, then click the button to download and install the plugin.

Once installed an extra post-build action called 'Push to Cloud Foundry' will appear in the drop down menu when configuring a project.

* In your project's configuration click the 'Add post-build action' drop down menu and select 'Push to Cloud Foundry'.
* In the 'Target' field enter 'https://api.cloud.service.gov.uk'.
* For credentials select the user created using the credentials plugin.
* Enter your organisation and the space the application will be deployed to. You do not need to tick 'Allow self-signed certificate' or 'Reset app if already exists'.
* The rest of the fields can be left with their default values. It expects you to have a manifest file called 'manifest.yml' in the root of your repository. If you do not, you can provide the path to application manifest, or enter manifest configuration directly into the plugin.
* Click 'Save'.

Further information can be found on the [Cloud Foundry plugin's wiki page](https://wiki.jenkins-ci.org/display/JENKINS/Cloud+Foundry+Plugin).

## Installing the Credentials Binding Plugin

* In Jenkins click on 'Manage Jenkins', then 'Manage Plugins'.
* Click on the 'Available' tab and find the Credentials Binding Plugin. Tick the box to select the plugin, then click the button to download and install the plugin.
* In your build configuration select the 'Use secret text(s) or file(s)' checkbox in the 'Build Environment' section.
* Click on the 'Add' drop down menu and select 'Username and password (separated)'.
* Choose your variable names and select the user whose credentials will be used.

Once this is set up any shell scripts you configure in Jenkins will have the credentials available as environment variables.

A basic 'execute shell' buildstep would look like this:

```
# Important: always set $CF_HOME to a location within your project.
# We set it above the workspace to not conflict with your repository.
export CF_HOME="${WORKSPACE}/../"

cf api https://api.cloud.service.gov.uk

# Note: the actual name of the environment variable is determined
# by what you enter into the Credentials Binding Plugin
cf auth "$CF_USER" "$CF_PASSWORD"

cf target -o myorg -s myspace
cf push

# Destroy token
cf logout
```

