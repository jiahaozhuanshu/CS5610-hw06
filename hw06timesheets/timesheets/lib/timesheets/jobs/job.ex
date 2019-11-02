defmodule Timesheets.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :description, :string
    field :hours, :integer
    field :jobcode, :string
    field :name, :string
    belongs_to :user, Timesheets.Users.User
    has_many :tasks, Timesheets.Tasks.Task
    

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:description, :name, :hours, :jobcode])
    |> validate_required([:description, :name, :hours, :jobcode])
  end
end
