defmodule TimesheetSpa.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :role, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:role])
  end
end
