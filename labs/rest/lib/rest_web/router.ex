defmodule RestWeb.Router do
  use RestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestWeb do
    pipe_through :api
  end
end
