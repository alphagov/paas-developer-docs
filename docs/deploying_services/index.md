Your application probably relies on backing services such as a database, an email delivery service or a monitoring system.

In Cloud Foundry, backing services are referred to as 'services' and are available through the Cloud Foundry ``cf marketplace`` command.

Currently, the only service available is the PostgreSQL database.

Your app can find out what backing services are available, and obtain credentials for the services, by parsing the VCAP_SERVICES environment variable.

We are going to add more services in future based on demand, including Elasticsearch and Redis. If you need a particular backing service that we don't yet support, please let us know at [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).