# Pushing an app to Cloud Foundry using Jenkins

There are two main approaches to pushing applications to the Government PaaS with [Jenkins](https://jenkins.io/):

1. Use the Cloud Foundry plugin for Jenkins (simple, less flexible)
1. Use custom scripts (advanced, allows full scripting of deployments)

Both of these approaches require you to add a Cloud Foundry username and password to Jenkins using the credentials plugin. To do this, follow the instructions on [Setting up the credentials plugin](/deploying_apps/jenkins/#setting-up-the-credentials-plugin).

Using the Cloud Foundry plugin is the easier approach and simply allows Jenkins to push your application to the Government PaaS as a post-build action: the equivalent of doing a `cf login` followed by a `cf push`. There is little scope for configuration beyond using the application manifest. To use the plugin, follow the [Setting up the Cloud Foundry plugin](/deploying_apps/jenkins/#setting-up-the-cloud-foundry-plugin) instructions.

Setting up custom scripts requires a bit more configuration, but allows you to fully script your deployment. To do this securely, you will need to follow the [Setting up custom scripts](/deploying_apps/jenkins/#setting-up-custom-scripts) instructions to make credentials available as environment variables.

## Setting up the credentials plugin

To install the credentials plugin:

1. In the Jenkins web interface, click on **Manage Jenkins**, then **Manage Plugins**.
2. Click on the **Installed** tab and check if "Credentials Plugin" is listed. If it's listed, skip the next step.
3. Click on the **Available** tab and find "Credentials Plugin". Check the box to select the plugin, then click either **Install without restart** or **Download now and install after restart** at the bottom of the interface.

Once the plugin is installed, you will see a **Credentials** link in the left-hand navigation menu. 

Now you can add credentials for the Cloud Foundry user you will be using to push apps from Jenkins.

You should provide the credentials for a dedicated PaaS user account created for use by Jenkins. Each user should have `SpaceDeveloper` access to a single space within your organisation. If you want to deploy to multiple spaces with Jenkins, use a different user account for each.

1. Click on **Credentials**, then **System**. By default, you will see a 'Global credentials (unrestricted)' domain. You should set up a different domain for each deployment target/PaaS user account.
2. Click **Add domain** and enter a name and description, then click **Save**.
3. Click **Add credentials** and enter the PaaS user account credentials. The kind of credentials is 'Username with password', which is typically selected by default.

You can now go on to either:

* [set up the Cloud Foundry plugin](/deploying_apps/jenkins/#setting-up-the-cloud-foundry-plugin) *or*
* [set up custom scripts](/deploying_apps/jenkins/#setting-up-custom-scripts)

## Setting up the Cloud Foundry plugin

Before you do this, make sure you first [set up the credentials plugin](/deploying_apps/jenkins/#setting-up-the-credentials-plugin).

1. In the Jenkins web interface, click on **Manage Jenkins**, then **Manage Plugins**.
2. Click on the **Available** tab and find "Cloud Foundry Plugin". Check the box to select the plugin, then click either **Install without restart** or **Download now and install after restart** at the bottom of the interface.

An extra post-build action called "Push to Cloud Foundry" is now available in the dropdown menu when you configure a job.

1. In your job's configuration, click the **Add post-build action** dropdown menu and select **Push to Cloud Foundry**.
2. In the **Target** field, enter `https://api.cloud.service.gov.uk`.
3. In **Credentials**, select the user you created using the credentials plugin.
4. Enter your organisation and the space the application will be deployed to. See [Orgs, Spaces and Targets](/deploying_apps/orgs_spaces_targets/) for more details about organisations and spaces. You do not need to tick "Allow self-signed certificate" or "Reset app if already exists".
5. The rest of the fields can be left with their default values. The plugin expects you to have a manifest file called `manifest.yml` in the root of the application folder. If you do not, you can provide the path to the application manifest, or enter a manifest configuration directly into the plugin.
6. Click **Save**.

Further information can be found on the [Cloud Foundry plugin's wiki page](https://wiki.jenkins-ci.org/display/JENKINS/Cloud+Foundry+Plugin).

## Setting up custom scripts

Before you do this, make sure you first [set up the credentials plugin](/deploying_apps/jenkins/#setting-up-the-credentials-plugin).

1. In the Jenkins web interface, click on **Manage Jenkins**, then **Manage Plugins**.
2. Click on the **Available** tab and find "Credentials Binding Plugin". Check the box to select the plugin, then click either **Install without restart** or **Download now and install after restart** at the bottom of the interface.
3. In your build configuration, select the **Use secret text(s) or file(s)**checkbox in the "Build Environment" section.
4. Click on the **Add** drop down menu and select **Username and password (separated)**.
5. Choose your variable names and select the user whose credentials will be used.

Once this is set up, any shell scripts you configure in Jenkins will have the credentials available as environment variables.

A basic 'execute shell' buildstep would look like this:

```
# Set CF_HOME per-job so that jobs do not share or overwrite each others' credentials.
# Remember to use a local subdirectory for your code to avoid including the credentials in your app.
export CF_HOME="${WORKSPACE}"
cd my-code

cf api https://api.cloud.service.gov.uk

# Note: the actual name of the environment variable is determined
# by what you enter into the Credentials Binding Plugin
cf auth "$CF_USER" "$CF_PASSWORD"

cf target -o myorg -s myspace
cf push

# Destroy token
cf logout
```

