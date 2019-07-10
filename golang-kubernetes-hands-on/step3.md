# Instrumenting Services within Kubernetes

Let's start by viewing the Datadog Agent's configuration.

If we open the `datadog-agent.yaml`, we'll see that it's run as a DaemonSet. 

DaemonSets allow us to schedule pods that run once per node. The Datadog Agent container mounts volumes on each node, in order to inspect the pods running, along with any host level information like RAM or CPU usage.

You can see this works by the `volumeMounts` section in our YAML. There we see all the directories that are mounted for the Agent to run, picking up both processes and Docker containers running on the system.

You'll notice the Datadog DaemonSet also runs the APM Agent, opening up a port on `8126`, allowing us to send our traces downstream to the Agent.

Along with the Traces port, we open port `8125` for UDP and DogstatsD. DogstatsD allows us to send custom metrics, for things we may want to see.

Popular custom metrics are things like user logins per minute, failed login attempts, orders placed, orders completed, etc. Custom metrics allow you to build dashboards more relevant to the systems of your business.

Just as we did in our `docker-compose`, we set a `env` tag in our environment variables. 

Setting this tag works just as before, allowing us to define the environment within which we want all of our servers to live together in Datadog.

This way, we can separate out our infrastructure into units that make sense for us. Think of the difference between staging and production. Or maybe you have different regions your data lives within. Setting an `env` tag allows you to view logically separate infrastructures within Datadog.