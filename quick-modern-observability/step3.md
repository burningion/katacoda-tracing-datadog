# Adding Distributed Tracing with APM

As mentioned before, our code has already been set up with instrumentation from Datadog. 

Depending on the programming language your application runs in, you may have a different process for instrumenting your code. It's always best to look at the [documentation](https://docs.datadoghq.com/tracing/setup/) for your specific language.

In our case, our applications run on [Ruby on Rails](https://docs.datadoghq.com/tracing/setup/ruby/#rails) and Python's [Flask](http://pypi.datadoghq.com/trace/docs/web_integrations.html#flask). 

We'll instrument each language differently.

## Installing the APM Language Library

For Ruby on Rails, we first added the `ddtrace` Gem to our Gemfile. Take a look at `store-frontend-broken-instrumented/store-frontend/Gemfile`{{open}} in the Katacoda file explorer, and notice we've added the Gem so we can start shipping traces.

Because we plan on also consuming logs from Rails and correlating them with traces, we've also added the `logging-rails` and `lograge` Gems. Both of these are documented on the Ruby [trace / logs](https://docs.datadoghq.com/tracing/setup/ruby/#for-logging-in-rails-applications-using-lograge-recommended) correlation part of the documentation.

Once these are both added to the list of our application's requirements, we must then add a `datadog.rb` to the list of initializers.

You'll find the file in `store-frontend-broken-instrumented/store-frontend/config/initializers/datadog.rb`{{open}}.

There, we control a few settings:

```ruby
Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'analytics_enabled': true, 'service_name': 'store-frontend', 'cache_service': 'store-frontend-cache', 'database_service': 'store-frontend-sqlite'}
  # Make sure requests are also instrumented
  c.use :http, {'analytics_enabled': true, 'service_name': 'store-frontend'}
end
```

We set `analytics_enabled` to be `true` for both our Rails auto instrumentation, and the `http` instrumentation.

This allows us to use Trace Search and Analytics from within Datadog.

By default, the Datadog Ruby APM library will ship traces to `localhost`, over port 8126. Because we're running within a `docker-compose`, we'll need to set an environment variable, `DD_AGENT_HOST`, for our Ruby library to know to ship to the Agent container instead.

With this, our Ruby application is instrumented. We're also able to continue traces downstream, utilizing Distributed Traces.

## Shipping Logs Correlated with Traces

To ship logs to Datadog, we've got to ensure they're converted to JSON format. This allows for filtering by specific parameters within Datadog.

Within our `store-frontend-broken-instrumented/store-frontend/config/development.rb`{{open}}, we see the specific code to ship our logs along with the correlating traces:

```ruby
  config.lograge.custom_options = lambda do |event|
    # Retrieves trace information for current thread
    correlation = Datadog.tracer.active_correlation
  
    {
      # Adds IDs as tags to log output
      :dd => {
        :trace_id => correlation.trace_id,
        :span_id => correlation.span_id
      },
      :ddsource => ["ruby"],
      :params => event.payload[:params].reject { |k| %w(controller action).include? k }
    }
  end
```

Next, let's look at how a Python application is instrumented.