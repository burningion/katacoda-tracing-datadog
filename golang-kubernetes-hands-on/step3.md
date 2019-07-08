# Instrumenting Services within Kubernetes

Let's start by viewing the Datadog Agent's configuration.

If we open the `datadog-agent.yaml`, we'll see that it's run as a DaemonSet. 

DaemonSets allow us to schedule pods that run once per node. The Datadog Agent container mounts volumes on each node, in order to inspect the pods running, along with any host level information like RAM or CPU usage.

The Datadog DaemonSet also runs the APM Agent, opening up a port on `8126`, allowing us to send our traces downstream to the Agent.

