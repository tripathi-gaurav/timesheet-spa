defmodule TimesheetSpaWeb.SessionController do
  use TimesheetSpaWeb, :controller

  action_fallback TimesheetSpaWeb.FallbackController

  alias TimesheetSpa.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    {resp, user} = Users.authenticate_user(email, password)
    IO.inspect resp
    IO.inspect user
    unless is_nil(user) do
      token = Phoenix.Token.sign(conn, "session", user.id)
      resp = %{token: token, user_id: user.id, user_name: user.name}
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:created, Jason.encode!(resp))
    else
      resp = %{errors: "Authentication Failed"}
      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:unauthorized, Jason.encode!(resp))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end