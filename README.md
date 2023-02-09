# `elixir-auth-google` _demo_

A basic example of using Google Auth in a Phoenix App.

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/elixir-auth-google-demo/ci.yml?label=build&style=flat-square&branch=main)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/elixir-auth-google-demo/main.svg?style=flat-square)](http://codecov.io/github/dwyl/elixir-auth-google-demo?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)](https://hex.pm/packages/elixir_auth_google)
[![contributions welcome](https://img.shields.io/badge/feedback-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/app-elixir-auth-google-demo/issues)
[![HitCount](https://hits.dwyl.com/dwyl/app-elixir-auth-google-demo.svg)](https://hits.dwyl.com/dwyl/app-elixir-auth-google-demo)

> Try it: https://elixir-auth-google-demo.herokuapp.com


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
mix phx.new app --no-ecto --no-webpack
```
> We don't need a database or static asset compilation for this demo.
> But we know they work fine
because we are using this package in our App in production.

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



## 1. Add the `elixir_auth_google` package to `mix.exs` 📦

Open your `mix.exs` file and add the following line to your `deps` list:

```elixir
def deps do
  [
    {:elixir_auth_google, "~> 1.3.0"}
  ]
end
```
Run the **`mix deps.get`** command to download.



## 2. Create the Google APIs Application OAuth2 Credentials ✨

Create your Google App and download the API keys
by follow the instructions in:
[`/create-google-app-guide.md`](https://github.com/dwyl/elixir-auth-google/blob/master/create-google-app-guide.md)

By the end of this step
you should have these two environment variables defined:

```yml
GOOGLE_CLIENT_ID=631770888008-6n0oruvsm16kbkqg6u76p5cv5kfkcekt.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=MHxv6-RGF5nheXnxh1b0LNDq
```

> ⚠️ Don't worry, these keys aren't valid.
They are just here for illustration purposes.

## 3. Create 2 New Files  ➕

We need to create two files in order to handle the requests
to the Google Auth API and display data to people using our app.

### 3.1 Create a `GoogleAuthController` in your Project

In order to process and _display_ the data returned by the Google OAuth2 API,
we need to create a new `controller`.

Create a new file called
`lib/app_web/controllers/google_auth_controller.ex`

and add the following code:

```elixir
defmodule AppWeb.GoogleAuthController do
  use AppWeb, :controller

  @doc """
  `index/2` handles the callback from Google Auth API redirect.
  """
  def index(conn, %{"code" => code}) do
    {:ok, token} = ElixirAuthGoogle.get_token(code, conn)
    {:ok, profile} = ElixirAuthGoogle.get_user_profile(token.access_token)
    conn
    |> put_view(AppWeb.PageView)
    |> render(:welcome, profile: profile)
  end
end
```
This code does 3 things:
+ Create a one-time auth token based on the response `code` sent by Google
after the person authenticates.
+ Request the person's profile data from Google based on the `access_token`
+ Render a `:welcome` view displaying some profile data
to confirm that login with Google was successful.

> Note: we are placing the `welcome.html.eex` template
in the `template/page` directory to save having to create
any more directories and view files.
You are free to organise your code however you prefer.

### 3.2 Create `welcome` template 📝

Create a new file with the following path:
`lib/app_web/templates/page/welcome.html.eex`

And type (_or paste_) the following code in it:
```html
<section class="phx-hero">
  <h1> Welcome <%= @profile.given_name %>!
  <img width="32px" src="<%= @profile.picture %>" />
  </h1>
  <p> You are <strong>signed in</strong>
    with your <strong>Google Account</strong> <br />
    <strong style="color:teal;"><%= @profile.email %></strong>
  <p/>
</section>
```


The Google Auth API `get_profile` request
returns profile data in the following format:
```elixir
%{
  email: "nelson@gmail.com",
  email_verified: true,
  family_name: "Correia",
  given_name: "Nelson",
  locale: "en",
  name: "Nelson Correia",
  picture: "https://lh3.googleusercontent.com/a-/AAuE7mApnYb260YC1JY7",
  sub: "940732358705212133793"
}
```
You can use this data however you see fit.
(_obviously treat it with respect, only store what you need and keep it secure_)


## 4. Add the `/auth/google/callback` to `router.ex`

Open your `lib/app_web/router.ex` file
and locate the section that looks like `scope "/", AppWeb do`

Add the following line:

```elixir
get "/auth/google/callback", GoogleAuthController, :index
```

That will direct the API request response
to the `GoogleAuthController` `:index` function we defined above.


## 5. Update `PageController.index`

In order to display the "Sign-in with Google" button in the UI,
we need to _generate_ the URL for the button in the relevant controller,
and pass it to the template.

Open the `lib/app_web/controllers/page_controller.ex` file
and update the `index` function:

From:
```elixir
def index(conn, _params) do
  render(conn, "index.html")
end
```

To:
```elixir
def index(conn, _params) do
  oauth_google_url = ElixirAuthGoogle.generate_oauth_url(conn)
  render(conn, "index.html",[oauth_google_url: oauth_google_url])
end
```

### 5.1 Update the `page/index.html.eex` Template

Open the `/lib/app_web/templates/page/index.html.eex` file
and type the following code:

```html
<section class="phx-hero">
  <h1>Welcome to Awesome App!</h1>
  <p>To get started, login to your Google Account: <p>
  <a href={@oauth_google_url}>
    <img src="https://i.imgur.com/Kagbzkq.png" alt="Sign in with Google" />
  </a>
</section>
```

The home page of the app now has a big "Sign in with Google" button:

![sign-in-button](https://user-images.githubusercontent.com/194400/70202961-3c32c880-1713-11ea-9737-9121030ace06.png)


Once the person completes their authentication with Google,
they should see the following welcome message:

![welcome](https://user-images.githubusercontent.com/194400/70201692-494db880-170f-11ea-9776-0ffd1fdf5a72.png)



To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
