defmodule TimesheetSpa.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role_id, :integer
      add :desc, :string

      timestamps()
    end

  end
end
