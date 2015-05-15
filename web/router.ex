defmodule Phitter.Router do
  use Phitter.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Phitter do
    pipe_through :browser # Use the default browser stack

    get "/", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

    get "/pages", PageController, :index
    resources "/pheets", PheetController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Phitter do
  #   pipe_through :api
  # end
end
