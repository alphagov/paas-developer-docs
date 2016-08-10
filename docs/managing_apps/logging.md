For logs to be captured by Cloud Foundry, your application should be writing them to `STDOUT`/`STDERR`, rather than a log file – see the framework-specific guidance in the menu.

## Current logs

The most direct way to view events related to your application through the deploy process is

```bash
cf logs APPNAME
```

Used alone, `cf logs` will tail the combined stream of logs from each Cloud Foundry service involved in your application deploy. Running with the `--recent` flag will stream the entire [Loggregator](https://docs.cloudfoundry.org/loggregator/architecture.html) buffer for your app.

```bash
cf logs APPNAME --recent
```

For more information about logs, see the Cloud Foundry documentation:

* [Information about the log format](https://docs.cloudfoundry.org/devguide/deploy-apps/streaming-logs.html)
* [Viewing your application's logs](https://docs.cloudfoundry.org/devguide/deploy-apps/streaming-logs.html#view)

## Example log

  	2015-03-16T17:37:47.82-0400 [DEA/1]      OUT Starting app instance (index 0) with guid GUID
  	2015-03-16T17:37:50.85-0400 [DEA/1]      ERR Instance (index 0) failed to start accepting connections
  	2015-03-16T17:37:53.54-0400 [API/0]      OUT App instance exited with guid GUID0 payload: {"cc_partition"=>"default", "droplet"=>"GUID0", "version"=>"GUID1", "instance"=>"GUID2", "index"=>0, "reason"=>"CRASHED", "exit_status"=>127, "exit_description"=>"failed to accept connections within health check timeout", "crash_timestamp"=>1426541870}

## ``cf events`` command

If you are trying to troubleshoot a problem and it's hard to understand what's happening from the logs, you can use the command:

```bash
cf events APPNAME
```

Running ``cf events`` shows you when an app starts, stops, restarts, or crashes (including error codes). The output is often easier to interpret than the output of ``cf logs``.



