defmodule PhoenixChat.Router do
  use PhoenixChat.Web, :router

  alias PhoenixChat.{AuthController, UserController}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", PhoenixChat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    resources "/users", PhoenixChat.UserController, except: [:new, :edit]
  end

  scope "/auth" do
    pipe_through [:api, :api_auth]

    get "/me", PhoenixChat.AuthController, :me
    post "/:identity/callback", PhoenixChat.AuthController, :callback
    delete "/signout", PhoenixChat.AuthController, :delete
  end
end
