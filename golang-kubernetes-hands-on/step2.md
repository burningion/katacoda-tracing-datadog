# Adding Services to Our Cluster

You can `kubectl apply -f <filename>` for each one of the remaining files in the YAML directory, and we should see our entire cluster spin up.

You should start with the two databases we have, `redis` and `postgres`, as the other containers rely on them running. After the databases, bring up the other services, and then last, the `frontend-service`.

The `frontend-service` requires the other services to be running first, so it knows where to connect to for API requests.

If you accidentally spin up the `frontend-service` before the rest, simply type `kubectl delete pod f<TAB>`, to have autocomplete finish the name of the running frontend service pod. Deleting the pod will delete the currently running instance, and a new one will be scheduled and deployed by kubernetes.

Check your services are running with a `kubectl get services`. If one is not up, check the status with a `kubectl get pods`.

If one has an error, you may need to `kubectl delete pod <podname>`.

Make sure you can visit your services by viewing the link below:

https://[[HOST_SUBDOMAIN]]-30001-[[KATACODA_HOST]].environments.katacoda.com/

If nothing loads, again, check to make sure all the pods came up with a `kubectl get pods`. Once they're all in the `Running` state, you should be able to hit the URL.

You can ensure your application and all the microservices are running properly by verifying that there are at least the 3 pumps visible by default. If there is just one, a piece of your deployment is still not deployed.

In the editor to the right, you should be able to also navigate to the `k8s-yaml-files` directory, and see your YAML files you've deployed.

Next, let's take a closer look at our YAML files, and see how we've instrumented our application.
