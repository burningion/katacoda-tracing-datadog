# Adding Autodiscovery Annotations to Our Services

Open the `postgres-deploy.yaml` file. You'll see it has annotations commented out.

Uncomment the annotations, and replace the username and password with the ones you created earlier.

Apply the autodiscovery checks by doing a `kubectl apply -f postgres-deploy.yaml` to the edited file.

Wait for the new pod to be deployed.

Switch back over to your Datadog backend, and go to the Metrics Explorer. You should be able to start typing `postgresq`, and see the metrics for our annotated PostgreSQL server.

Next, let's add more annotations to the rest of our services.