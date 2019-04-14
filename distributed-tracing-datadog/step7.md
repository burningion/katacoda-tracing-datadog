# Modeling Failure in Our Systems

For our final challenge, let's start introducing errors and killing servers.

Altough we set up monitoring, because of the nature of the workshop, we don't have email accounts to receive alerts.

Open a new terminal window by clicking the `+` sign within Katacoda. There is an option called `Open New Terminal`.

Try removing a running service with a:

```
$ docker ps
$ docker kill <containerid>
```

Remember, if you kill the `iot-frontend`, the rest of the downstream services will die.

If you break something, switch back to your terminal running `docker-compose`. Remember, you can `CTRL+C`, followed by pressing up to rerun the last command and bring back up the entire suite of services.

Watch for the difference in behavior for the `iot-frontend` web application, along with the change within the Datadog backend.

How would you model and alert for services being broken?

Once you've brought a service down, and seen the effect, try adding a much higher latency back into the `pumps-api`.

Maybe add a 3 second sleep instead? What happens to the service map?

You can also export and build dashboards based upon services by clicking `Export to Timeboard`. Design a new timeboard to monitor the status of your services.

Finally, we can try adding software version numbers to our trace tags, and put them in the Trace Search and Analytics.

This can give us a way to track performance changes across software releases. Try it out on your own.