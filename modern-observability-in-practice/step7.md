# Discovering a Suboptimal SQL Query

As noted before, with the Service List, we can see at a quick glance see endpoints that are running slower than the rest.

Now that we've got the time down on our requests, let's see if we can fix one more problematic SQL query.

It looks like we've got a classic N+1 query on our `discounts-service`. If you scroll in, there appears to be a _lot_ of trips to the database for a request.

It seems the last developer didn't realize the way they structured their code meant making multiple trips to the database when there shouldn't have been. 

There should be a line of code which states what happened, with a fix. Edit the `discounts.py` file, and let's see if the changes written work.

With this, we've now made a great first attempt at improving the experience for our users.