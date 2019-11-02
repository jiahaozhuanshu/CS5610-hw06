defmodule Timesheets.Repo.Migrations.AddPassword do
  use Ecto.Migration


  def change do
    alter table("users") do
      add :password_hash, :string, default: "", null: false
      add :is_manager, :boolean, default: false, null: false
      
    end
  end
end
