chimp(1) -- super light mailchimp client
========================================

## SYNOPSIS

    Chimp.connect("acbd18db4cc2f85cedef654fccc4a4d8-us4")

    # Get all lists for your account
    Chimp.current.lists
    # => {"total"=>1, "data"=>[{"id"=>"l654321", ...}]]}

    # Add a new email to one of your lists identified by id
    Chimp.current.subscribe("foo@bar.com", "l654321")
    # => "true"

    # Unsubscribe an existing email
    Chimp.current.unsubscribe("foo@bar.com", "l654321")
    # => "true"

## DESCRIPTION

In order to start using Chimp, simply follow the following
instructions:

1. Signup for an account at http://mailchimp.com
2. Create at least one subscriber list.
3. Generate an API key.

As soon as you generate an API key, you can then start
using Chimp as described in the synopsis above.

## INSTALLATION

    $ gem install chimp

## CONFIGURATION TIPS

If you're used to doing configuration via environment
variables, similar to how Heroku does configuration, then
you can simply set an environment variable in your
production machine like so:

    export MAILCHIMP_API_KEY=acbd18db4cc2f85cedef654fccc4a4d8-us4

Then you can connect using the environment variable in your
code like so:

    Chimp.connect(ENV["MAILCHIMP_API_KEY"])
