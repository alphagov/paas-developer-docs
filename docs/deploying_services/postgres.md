
Government PaaS enables you to create a PostgreSQL database service (powered by Amazon Web Services) and bind it to your app. 

In Cloud Foundry, each service may have multiple plans available with different characteristics.

Currently, Government PaaS offers a ``postgres`` service which is available with two separate plans: 

* ``M-dedicated-9.5``
* ``M-HA-dedicated-9.5`` (high availability, recommended for production)

The number in the plan name (in this case, ``9.5``) is the PostgreSQL version.

``postgres`` is considered a paid service. Paid services may not be enabled on your account. If you try to create a service and receive an error stating "service instance cannot be created because paid service plans are not allowed", please contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](gov-uk-paas-support@digital.cabinet-office.gov.uk).


To create a service and bind it to your app:

1. From the command line, run:  

    ``cf marketplace``  

    to see the available services.

    You will see output like this:

    
        service     plans                                   description
        postgres    M-dedicated-9.5*, M-HA-dedicated-9.5*   AWS RDS PostgreSQL service

2.  Run: 

    ``cf marketplace -s postgres``

    to see details of the available plans.

3. Run: 

    ``cf create-service SERVICE PLAN SERVICE_INSTANCE``

    where SERVICE is the service you want, PLAN is the plan you want, and SERVICE_INSTANCE is a unique, descriptive name for this instance of the service.

    Note that for a production service, we strongly recommend you select the high-availability plan (``M-HA-dedicated-9.5``).

3. It may take some time for the service instance to be set up. To find out its status, run:  

      ``cf service SERVICE_INSTANCE ``

4. Wait until the service status is 'available'. You can now bind the PostgreSQL service to your app. Run:

    ``cf bind-service APPLICATION SERVICE_INSTANCE``

    where APPLICATION is the name of a deployed instance of your application (exactly as specified in your manifest or push command).

5. Your app should now able to access the PostgreSQL service. You may need to restart the app to connect.


## Accessing PostgreSQL from your app

Your app must make a [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) connection to the PostgreSQL service. Most libraries use TLS by default.

Your app will need to parse the ``VCAP_SERVICES`` [environment variable](/deploying_apps/#environment-variables) to get details of the PostgreSQL service (or use a library that does so).

(Note that if your app is written in Ruby, the Cloud Foundry Ruby buildpack will automatically parse ``VCAP_SERVICES`` and set DATABASE_URL to the first database found.)

Use ``cf env APPNAME`` to see the environment variables.

You can check for database connection errors by viewing the recent logs with ``cf logs APPNAME --recent``.

## PostgreSQL service maintenance times

The PaaS PostgreSQL service is currently provided by Amazon Web Services RDS. Each PostgreSQL service you create will have a randomly-assigned weekly 30 minute maintenance window, during which there may be brief downtime. (To minimise downtime, select the ``M-HA-dedicated-9.5`` high availability plan). Minor version upgrades (for example from 9.4.1 to 9.4.2) will be applied during this window.

For more details, see the [Amazon RDS Maintenance documentation](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html) [external page].

If you need to know the time of your maintenance window, please contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](gov-uk-paas-support@digital.cabinet-office.gov.uk). We will add the ability to set the time of the maintenance window in a future version of Government PaaS.




