# Redeploying Alongside Legacy Code

Now that we've got a working microservice, let's jump back in and swap it out in our existing Frontend API.

That's easy enough to do, we'll add an environment variable for choosing which version to use on our replacement endpoint. We can set it to be a decimal, test for improvements, and then keep our new service with a simple environment variable.

