defmodule Timesheets.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :description, :text
      add :name, :string
      add :hours, :integer
      add :jobcode, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end


    create index(:jobs, [:user_id])
  end
end
