While the Government PaaS is built using Cloud Foundry technology, we don't  support all Cloud Foundry features. This section explains some Cloud Foundry features that are not enabled, as well as some limitations of the beta phase.

## Custom buildpacks are not supported

Cloud Foundry uses buildpacks to provide runtime and framework support for applications in different languages. 

Government PaaS does not support [custom buildpacks](https://docs.cloudfoundry.org/buildpacks/custom.html), only the [standard buildpacks](https://docs.cloudfoundry.org/buildpacks/).

If you want to use a custom buildpack because you need a newer version of a runtime or framework, please note that we update the standard buildpacks on a regular basis (approximately monthly).

If you'd like to use custom buildpacks, please contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).

## API access may have brief outages during beta

During the beta period, there may be occasional brief periods where API access is unavailable during a platform update, causing commands sent from the command line client to fail. 

If you find that a valid command is failing and the error message does not explain the problem, please wait 5 minutes before trying the command again. If the error persists for more than 5 minutes, it is unlikely to be caused by a platform update and you should contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).

We are working on a fix to prevent the interruption of API access when we update the platform.