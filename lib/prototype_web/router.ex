defmodule PrototypeWeb.Router do
  use PrototypeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Prototype.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PrototypeWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", SessionController, :new
    get "/logout", SessionController, :delete
    resources "/users", UserController
    resources "/customers", CustomerController
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", PrototypeWeb do
  #   pipe_through :api
  # end
end
