defmodule ReqBinWeb.Router do
  use ReqBinWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReqBinWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/req", ReqBinWeb do
    pipe_through :api

    post "/", ReqController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReqBinWeb do
  #   pipe_through :api
  # end
end
