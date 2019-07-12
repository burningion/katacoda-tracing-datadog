# Redeploying Alongside Legacy Code

Now that we've got a working microservice, let's jump back in and swap it out in our existing Frontend API.

That's easy enough to do, we'll add an environment variable for choosing which version to use on our replacement endpoint. We can set it to be a decimal, test for improvements, and then keep our new service with a simple environment variable.

Our new frontend code can be found in `frontend-updated/api.py`.

We create a new environment variable, `USE_NEW_API`, and set it to be the probability that the new Golang API gets called:

```python
# generate requests for one user to see tagged
# enable user sampling because low request count
@app.route('/generate_requests_user')
def call_generate_requests_user():
    use_new_api = 0
    try:
        use_new_api = float(environ['USE_NEW_API'])
    except:
        app.logger.info("USE_NEW_API not set, defaulting to zero")
    
    if random.random() < use_new_api:
        answer = requests.get(f"{GOLANG_URL}/generate_requests_user")
        return jsonify({'response': str(answer.content)})

    users = requests.get(f"{NODE_URL}/users").json()
    user = random.choice(users)
    span = tracer.current_span()
    span.context.sampling_priority = USER_KEEP
    span.set_tags({'user_id': user['id']})

    output = subprocess.check_output(['ddtrace-run',
                                     '/app/traffic_generator.py',
                                     '20',
                                     '100',
                                     f"{NODE_URL}/users/" + user['uid']])
    app.logger.info(f"Chose random user {user['name']} for requests: {output}")
    return jsonify({'random_user': user['name']})
```

To deploy this, we'll need to change the image being pulled for the `frontend-service` to:

```
burningion/golang-k8s-distributed-tracing-frontend:latest
```

And while we're there, we also need to set the environment variable `USE_NEW_API`:

```
        - name: USE_NEW_API
          value: '0.5'
```

With this, we can now do a `kubectl apply -f frontend-service.yaml`, and see what improvements we see in our newly deployed service.

Once we're confident in our changes, we only need to set `USE_NEW_API` to `1.0`, and our Golang service is now running in production! 

We can then confidently get rid of the legacy infrastructure, and move on to the next challenge.