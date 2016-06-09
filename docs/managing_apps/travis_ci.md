You can enable continuous deployment to PaaS using Travis-CI.

1. Add the GitHub repo for your project to [Travis-CI](http://travis-ci.org).

2. Make sure you have the Travis command line client installed by running:

    ``gem install travis``

3. From the local directory where you checked out your project, run the Cloud Foundry set-up script:

    ``travis setup cloudfoundry``

4. Follow the prompts. When you're done, the script will have appended all the necessary markup to a `.travis.yml` file in the current directory.

2. Add this line to the top of the `.travis.yml` file:

    ``edge: true``

    Note that because `.travis.yml` begins with a `.` it may be hidden by default by your operating system.

5. Once you merge a Pull Request, Travis will run and deploy the site.