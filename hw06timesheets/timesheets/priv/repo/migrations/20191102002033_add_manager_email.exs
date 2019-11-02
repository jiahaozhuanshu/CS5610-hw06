defmodule Timesheets.Repo.Migrations.AddManagerEmail do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :manager_email, :string, default: "", null: false
  end
end

end
