
Government PaaS enables you to create a PostgreSQL database service and bind it to your app.

To do this:

1. From the command line, run:  

    ``cf marketplace``  

    to see the available services.

    You will see output like this:

	
    	service     plans      								description
		postgres    M-dedicated-9.5*, M-HA-dedicated-9.5*   AWS RDS PostgreSQL service

2. Select a suitable PostgreSQL service. Each service may have 
   multiple plans available with different characteristics.

    Plans with an associated cost are marked with an asterisk. 

    Run: 

    ``cf create-service SERVICE PLAN SERVICE_INSTANCE``

    where SERVICE is the service you want, PLAN is the plan you want, and SERVICE_INSTANCE is a unique, descriptive name for this instance of the service.


3. It may take some time for the service instance to be set up. To find out its status, run:  

      ``cf service SERVICE_INSTANCE ``


4. Wait until the service status is 'available'. You can now bind the PostgreSQL service to your app. Run:

    ``cf bind-service APPLICATION SERVICE_INSTANCE``

    where APPLICATION is the name of a deployed instance of your application (exactly as specified in your manifest or push command).

5. The app should now be able to access PostgreSQL. You can check that there are no database connection errors by viewing the recent logs with ``cf logs APP_NAME --recent``.
