# Deploying Our Application to Kubernetes

The workshop already has an application ready to be deployed to kubernetes included.

First, ensure your kubernetes cluster has been initialized, and both nodes have been added. You can do this by running `kubectl get nodes` in host1.

On host1, change into the YAML file directory with a `cd k8s-yaml-files`. You should be able to `ls` and see the YAML files for every service we plan on running in our cluster.

First, add your Datadog API key to the secrets. You can do this with a:

```bash
$ kubectl create secret generic datadog-api --from-literal=token=<YOUR_DATADOG_API_KEY>
```

Once that's done, we'll next need to create a secret username and password for our PostgreSQL database.

```bash
$ kubectl create secret generic postgres-user --from-literal=token=postgres
$ kubectl create secret generic postgres-password --from-literal=token=<YOUR_PASSWORD>
```

Finally, spin up the Datadog Agent