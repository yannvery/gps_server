defmodule GpsServerWeb.Router do
  use GpsServerWeb, :router

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

  scope "/", GpsServerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", GpsServerWeb.Api do
    pipe_through :api
    get "/position", PositionController, :show
    post "/position", PositionController, :create
  end
end
