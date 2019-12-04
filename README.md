# auth-demo

A basic example of using Google Auth in a Phoenix App.

[![Build Status](https://img.shields.io/travis/dwyl/elixir-auth-google/master.svg?style=flat-square)](https://travis-ci.org/dwyl/elixir-auth-google)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/elixir-auth-google/master.svg?style=flat-square)](http://codecov.io/github/dwyl/elixir-auth-google?branch=master)
![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/elixir-auth-google/issues)




# _Why_? 🤷



# _What_? 💭

This project is intended as a _barebones_ demonstration
of using
[`elixir-auth-google`](https://github.com/dwyl/elixir-auth-google)
to add support for "***Sign-in with Google***" to your Phoenix Application.

# _Who_? 👥

This demos is intended for people of all Elixir/Phoenix skill levels.
Anyone who wants the "***Sign-in with Google***" functionality
without the extra steps to configure a whole auth _framework_.


# _How?_ 💻


1. Create a New Phoenix App

Create a new project if you don't already have one:

```
mix phx.new app
```

If prompted to install dependencies `Fetch and install dependencies? [Yn]`
Type `y` and hit the `[Enter]` key to install.

You should see something like this:
```
* running mix deps.get
* running cd assets && npm install && node node_modules/webpack/bin/webpack.js
* running mix deps.compile
```

Make sure that everything works before proceeding:
```
mix test
```
You should see:
```
Generated app app
...

Finished in 0.02 seconds
3 tests, 0 failures
```
The default tests pass and you know phoenix is compiling.

Run the web application:

```
mix phx.server
```

and visit the endpoint in your web browser: http://localhost:4000/
![phoenix-default-home](https://user-images.githubusercontent.com/194400/70126043-0d174b00-1670-11ea-856e-b31e593b5844.png)


2.

--no-context


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
