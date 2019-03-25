# Adding Services to Our Cluster

You can `kubectl apply -f <filename>` for each one of the remaining files in the YAML directory, and we should see our entire cluster spin up.

The `frontend-service` requires the other services to be running first, so it knows where to connect to for API requests.

If you accidentally spin up the `frontend-service` before the rest, simply type `kubectl delete pod f<TAB>`, to have autocomplete finish the name of the running frontend service pod.

Check your services are running with a `kubectl get services`.

Make sure you can visit your services by viewing the link below:

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/

In the editor to the right, you should be able to also navigate to the `k8s-yaml-files` directory, and see your YAML files you've deployed.

Next, let's take a look at our YAML files, and see which applications we can add monitoring to with autodiscovery.
