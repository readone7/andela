defmodule AndelaWeb.Router do
  use AndelaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AndelaWeb do
    pipe_through :api
    post "/reaction", ReactionController, :create

    get "/reaction_counts/:content_id", ReactionController, :count
  end
end
