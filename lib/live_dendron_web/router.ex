defmodule LiveDendronWeb.Router do
  use LiveDendronWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_flash
    plug :fetch_live_flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveDendronWeb do
    pipe_through :browser

    get "/", HomeController, :show
  end
end
