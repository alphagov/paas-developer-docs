
Government PaaS enables you to create a PostgreSQL database service (powered by Amazon Web Services) and bind it to your app. 

In Cloud Foundry, each service may have multiple plans available with different characteristics.

Currently, Government PaaS offers a ``postgres`` service which is available with two separate plans: 

* ``M-dedicated-9.5``
* ``M-HA-dedicated-9.5`` (high availability, recommended for production)


To create a service and bind it to your app:

1. From the command line, run:  

    ``cf marketplace``  

    to see the available services.

    You will see output like this:

	
    	service     plans      								description
		postgres    M-dedicated-9.5*, M-HA-dedicated-9.5*   AWS RDS PostgreSQL service

2.  Run: 

    ``cf marketplace -s postgres``

    to see details of the available plans.

3. Run: 

    ``cf create-service SERVICE PLAN SERVICE_INSTANCE``

    where SERVICE is the service you want, PLAN is the plan you want, and SERVICE_INSTANCE is a unique, descriptive name for this instance of the service.

    Note that for a production service, we strongly recommend you select the high-availability plan (``M-HA-dedicated-9.5``).

    Paid services may need to be enabled on your account; if you receive an error stating "service instance cannot be created because paid service plans are not allowed", please contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](gov-uk-paas-support@digital.cabinet-office.gov.uk).


3. It may take some time for the service instance to be set up. To find out its status, run:  

      ``cf service SERVICE_INSTANCE ``


4. Wait until the service status is 'available'. You can now bind the PostgreSQL service to your app. Run:

    ``cf bind-service APPLICATION SERVICE_INSTANCE``

    where APPLICATION is the name of a deployed instance of your application (exactly as specified in your manifest or push command).

5. Your app is now able to access the PostgreSQL service.


## Accessing PostgreSQL from your app

Your app will need to parse the ``VCAP_SERVICES`` [environment variable](/deploying_apps/#environment-variables) to get details of the PostgreSQL service (or use a library that does so).

(Note that if your app is written in Ruby, the Cloud Foundry Ruby buildpack will automatically parse ``VCAP_SERVICES`` and set DATABASE_URL to the first database found.)

Use ``cf env APPNAME`` to see the environment variables.

You can check for database connection errors by viewing the recent logs with ``cf logs APPNAME --recent``.
