# auth-demo

A basic example of using Google Auth in a Phoenix App.

![Build Status](https://img.shields.io/travis/com/dwyl/elixir-auth-google/master?color=bright-green&style=flat-square)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/elixir-auth-google/master.svg?style=flat-square)](http://codecov.io/github/dwyl/elixir-auth-google?branch=master)
![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/elixir-auth-google/issues)


# _Why_? 🤷

As developers we are _always learning_ new things.
When we learn, we love having _detailed docs and **examples**_
that explain _exactly_ how to get up-and-running.
We write examples because we want them _ourselves_,
if you find them useful, please :star: the repo to let us know.


# _What_? 💭

This project is intended as a _barebones_ demonstration
of using
[`elixir-auth-google`](https://github.com/dwyl/elixir-auth-google)
to add support for "***Sign-in with Google***" to any Phoenix Application.

# _Who_? 👥

This demos is intended for people of all Elixir/Phoenix skill levels.
Anyone who wants the "***Sign-in with Google***" functionality
without the extra steps to configure a whole auth _framework_.

Following all the steps in this example should take around 10 minutes.
However if you get stuck, please don't suffer in silence!
Get help by opening an issue: https://github.com/dwyl/elixir-auth-google/issues

# _How?_ 💻

This example follows the step-by-instructions in the docs
[github.com/dwyl/elixir-auth-google](https://github.com/dwyl/elixir-auth-google)


## 0. Create a New Phoenix App

Create a new project if you don't already have one:

> _If you're adding `elixir_auth_google` to an **existing app**,
you can **skip this step**. <br />
Just make sure your app is in a known working state before proceeding_.

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



## 1. Add the `elixir_auth_google` package to `mix.exs`

Open your `mix.exs` file and add the following line to your `deps` list:

```elixir
def deps do
  [
    {:elixir_auth_google, "~> 1.0.0"}
  ]
end
```
Run the **`mix deps.get`** command to download.



## 2. Create the Google APIs Application OAuth2 Credentials

Create your Google App and download the API keys
by follow the instructions in:
[``/create-google-app-guide.md`](https://github.com/dwyl/elixir-auth-google/blob/master/create-google-app-guide.md)

By the end of this step
you should have these two environment variables set:

```yml
GOOGLE_CLIENT_ID=631770888008-6n0oruvsm16kbkqg6u76p5cv5kfkcekt.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=MHxv6-RGF5nheXnxh1b0LNDq
```

> ⚠️ Don't worry, these keys aren't valid.
They are just here for illustration purposes.



3. Create a `GoogleAuthController` in your Project

https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html


--no-context


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
