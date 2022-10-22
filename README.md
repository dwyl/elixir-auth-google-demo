<div align="center">

# `elixir-auth-google` _demo_

A basic example of using Google Auth in a Phoenix App.

[![Build Status](https://img.shields.io/travis/com/dwyl/elixir-auth-google-demo/master?color=bright-green&style=flat-square)](https://travis-ci.com/github/dwyl/elixir-auth-google-demo)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/elixir-auth-google/master.svg?style=flat-square)](http://codecov.io/github/dwyl/elixir-auth-google?branch=master)
![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/elixir-auth-google/issues)

> Try it: https://elixir-auth-google-demo.herokuapp.com

</div>

# _Why_? 🤷

As developers we are _always learning_ new things.
When we learn, we love having _detailed docs and **examples**_
that explain _exactly_ how to get up-and-running.
We write examples because we want them _ourselves_,
if you find them useful, please :star: the repo to let us know.

# _What_? 💭

This project is intended as a _barebones_ demonstration of using

[`elixir-auth-google`](https://github.com/dwyl/elixir-auth-google)

to add support for "**_Sign-in with Google_**" to any Phoenix Application.

We also demonstrate how to use the **One tap**, the latest authentication functionality from Google.

# _Who_? 👥

This demos is intended for people of all Elixir/Phoenix skill levels.
Anyone who wants the "**_Sign-in with Google_**" functionality
without the extra steps to configure a whole auth _framework_.

Following all the steps in this example should take around 10 minutes.
However if you get stuck, please don't suffer in silence!
Get help by opening an issue: https://github.com/dwyl/elixir-auth-google/issues

# _How?_ 💻

This example follows the step-by-instructions in the docs
[github.com/dwyl/elixir-auth-google](https://github.com/dwyl/elixir-auth-google)

## 0. Create a New Phoenix App

**[I removed this step to make it shorter]**

## 1. Add the `elixir_auth_google` package to `mix.exs` 📦

Open your `mix.exs` file and add the following line to your `deps` list:

> NDLR: version **"1.5.0"** <- ?

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

By the end of this step, you should have these two environment variables defined:

```yml
GOOGLE_CLIENT_ID=631770888008-6n0oruvsm16kbkqg6u76p5cv5kfkcekt.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=MHxv6-RGF5nheXnxh1b0LNDq
```

> ⚠️ Don't worry, these keys aren't valid.
> They are just here for illustration purposes.

## 3. Create 2 New Files ➕

We need to create two files in order to handle the requests
to the Google Auth API and display data to people using our app.

### 3.1 Create a `GoogleAuthController` in your Project

In order to process and _display_ the data returned by the Google OAuth2 API, we need to create a new `controller`.

Create a new file called:
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

- Create a one-time auth token based on the response `code` sent by Google
  after the person authenticates.
- Request the person's profile data from Google based on the `access_token`
- Render a `:welcome` view displaying some profile data
  to confirm that login with Google was successful.

> Note: we are placing the `welcome.html.eex` template
> in the `template/page` directory to save having to create
> any more directories and view files.
> You are free to organise your code however you prefer.

### 3.2 Create `welcome` template 📝

Create a new file with the following path:
`lib/app_web/templates/page/welcome.html.eex`

And type (_or paste_) the following code in it:

```html
<section class="phx-hero">
  <h1>
    Welcome <%= @profile.given_name %>!
    <img width="32px" src="<%= @profile.picture %>" />
  </h1>
  <p>
    You are <strong>signed in</strong> with your
    <strong>Google Account</strong> <br />
    <strong style="color:teal;"><%= @profile.email %></strong>
  </p>

  <p />
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
  <p>To get started, login to your Google Account:</p>
  <p>
    <a href="<%= @oauth_google_url %>">
      <img src="https://i.imgur.com/Kagbzkq.png" alt="Sign in with Google" />
    </a>
  </p>
</section>
```

The home page of the app now has a big "Sign in with Google" button:

![sign-in-button](https://user-images.githubusercontent.com/194400/70202961-3c32c880-1713-11ea-9737-9121030ace06.png)

Once the person completes their authentication with Google,
they should see the following welcome message:

![welcome](https://user-images.githubusercontent.com/194400/70201692-494db880-170f-11ea-9776-0ffd1fdf5a72.png)

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

## 6 Use the One tap login

### 6.0 Copy the module `GoogleCerts` into your project

The module `GoogleCerts` is needed in your project.
You can **copy** :scissors: :scissors: the file `/lib/app/google_certs.ex` and paste it into your project.
This module verifies against Google's public keys the validity of the JWT you will receive and extracts the user's credentials from it.

### 6.1. Create a `OneTapController` in your Project 📝

Create a new file called:
[`lib/app_web/controllers/one_tap_controller.ex`]

Add the following code:

```elixir
defmodule AppWeb.OneTapController do
  use Phoenix.Controller
  action_fallback AppWeb.LoginError

  @doc """
  handles the callback from Google redirect.
  """

  def index(conn, %{"credential" => jwt}) do
    with {:ok, profile} <-
      App.GoogleCerts.verified_identity(jwt) do

    conn
    |> fetch_session()
    |> put_session(:profile, profile)
    |> put_view(AppWeb.WelcomeView)
    |> redirect(to: AppWeb.Router.Helpers.welcome_path(conn, :index))
    end
  end
end
```

This code does 3 things:

- receives a one-time auth `jwt` sent by Google after the user authenticates,
- verifies the `jwt` against Google's public key and retrieves the users credentials. This use the module `GoogleCerts` located at `/lib/app/google_certs.ex`
- redirects to the `welcome` controller to display some profile data
  to confirm that login with Google was successful,
- or falls back to the error page

### 6.2 Create the `/auth/one_tap` Endpoint 📍

Open your **`router.ex`** file and locate the section that looks like `pipeline :api"`.

Add the new `POST` endpoint: Google will send data :mailbox_with_mail: there!

```elixir
pipeline :api do
  plug(:accepts, ["json"])

  post("/auth/one_tap",
    AppWeb.OneTapController,
    :index
  )
end
```

### 6.3 Add the "Login with Google" Button to your Template ✨

We leave the controller:

`lib/app_web/controllers/page_controller.ex`

as it is. It renders the template:

`[/lib/app_web/templates/page/index.html.eex]`

Update the template with the following code:

```html
<script
  src="https://accounts.google.com/gsi/client"
  async defer>
</script>

<div id="g_id_onload"
  data-client_id={System.get_env("GOOGLE_CLIENT_ID")}
  data-login_uri=""   <------- see the note
  data-auto_prompt="true"
  >
</div>
<div class="flex items-center">
  <div class="g_id_signin"
    data-type="standard"
    data-size="large"
    data-theme="outline"
    data-text="sign_in_with"
    data-shape="rectangular"
    data-logo_alignment="left">
  </div>
</div>
```

> **Note about the fallback URI**: Google needs a URL to send back the data. They ask for an **absolute path**. You must use the **same** URL as the one you used in the **Google console**.

- you can fill directly the fallback URI in the template:

```elixir
data-login_uri="http://localhost:4000/auth/google/callback"
```

- or use Javascript for this: open your **`app.js`** file and add the code:

```js
const oneTap = document.querySelector("#g_id_onload");

if (oneTap) {
  oneTap.dataset.login_uri = window.location.href + "/auth/google/callback";
}
```

### 6.4 Create the `welcome` flow 📝

Instead of being able to render directly from the callback controller, we need an extra step: create the "welcome" flown.
This means that we add a controller, a view and a template.

- create a new controller:
  `[lib//app_web/controllers/welcome_controller.ex]`

```elixir
defmodule AppWeb.WelcomeController do
  use Phoenix.Controller

  def index(conn, _p) do
    profile = get_session(conn, :profile)
    render(conn, "index.html", profile: profile)
  end
end
```

- create a "welcome" view:
  `[lib/app_web/views/welcome_view.ex]`

```elixir
defmodule AppWeb.WelcomeView do
  use AppWeb, :view
end
```

- create the template:
  `[lib/app_web/templates/welcome/index.html.heex]`

```elixir
<section class="phx-hero">
  <h1> Welcome <%= @profile.given_name %>!
  <img width="32px" src={@profile.picture} >
  </h1>
  <p> You are <strong>signed in</strong>
    with your <strong>Google Account</strong> <br />
    <strong style="color:teal;"><%= @profile.email %></strong>
  </p>
</section>
```

### 6.5 Error handler :x:

For good measure, we used an error fallback controller.
In case of an error in the callback controller, the directive `action_fallback` will direct the flow to this error controller.

```elixir
defmodule AppWeb.LoginError do
  use Phoenix.Controller

  def call(conn, {:error, message}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_flash(:error, inspect(message))
    |> put_view(AppWeb.PageView)
    |> redirect(to: AppWeb.Router.Helpers.page_path(conn, :index))
    |> halt()
  end
end
```

Et voilà! :rocket:
