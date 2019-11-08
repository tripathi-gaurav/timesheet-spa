defmodule TimesheetSpaWeb.Router do
  use TimesheetSpaWeb, :router

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

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug TimesheetSpa.Plugs.FetchCurrentUser
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/ajax", TimesheetSpa do
    pipe_through :ajax

    resources "/roles", RoleController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/jobs", JobController, except: [:new, :edit]
    resources "/contracts", ContractController, except: [:new, :edit]
    resources "/sheets", SheetController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]

  end
  
  scope "/", TimesheetSpaWeb do
    pipe_through :browser

    get "/", PageController, :index
    # Wildcard path must come *last*, including after
    # other scopes.
    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetSpaWeb do
  #   pipe_through :api
  # end
end
