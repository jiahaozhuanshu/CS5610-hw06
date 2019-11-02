# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheets.Repo.insert!(%Timesheets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Timesheets.Repo
alias Timesheets.Users.User
alias Timesheets.Jobs.Job

Repo.insert!(%User{name: "Alice", email: "alice@example.com",})
Repo.insert!(%User{name: "Bob", email: "bob@example.com"})

Repo.insert!(%Job{jobcode: "VAOR-01", hours: 20, name: "Cyborg Arm", description: "This is Job1.", user_id: 1})
Repo.insert!(%Job{jobcode: "VAOR-02", hours: 45, name: "Sobriety Pill", description: "This is Job2.", user_id: 2})
Repo.insert!(%Job{jobcode: "VAOR-03", hours: 12, name: "Rat Cancer", description: "This is Job3.", user_id: 3})
