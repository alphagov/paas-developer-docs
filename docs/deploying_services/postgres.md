## Creating a PostgreSQL Service

PaaS allows you to create a PostgreSQL database service and bind it to your app.

To do this:

1. From the command line, run:

    ```
    cf marketplace
    ```

    to see the available services.

    You will see output like this:

	
    	service     plans      								description
		postgres    M-dedicated-9.5*, M-HA-dedicated-9.5*   AWS RDS PostgreSQL service

1. Select a suitable PostgreSQL service and plan. Each service may have multiple plans available with different characteristics.
 Plans with an associated cost will be marked with a star. 
Run: 

   ```
   cf create-service SERVICE PLAN SERVICE_INSTANCE
   ```

   where SERVICE is the service you want, PLAN is the plan you want, and SERVICE_INSTANCE is a unique, descriptive name for this instance of the service.

3. It may take some time for the service instance to be set up. To find out its status, run:

   ```
   cf service SERVICE_INSTANCE 
   ```

4. When the service status is 'available', run:

   ```
   cf bind-service APPLICATION SERVICE_INSTANCE
   ```

   where APPLICATION is the name of your application (exactly as specified in your manifest or push command).
