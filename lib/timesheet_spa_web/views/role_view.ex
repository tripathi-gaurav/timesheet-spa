defmodule TimesheetSpaWeb.RoleView do
  use TimesheetSpaWeb, :view
  alias TimesheetSpaWeb.RoleView

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id,
      role_id: role.role_id,
      desc: role.desc}
  end
end
