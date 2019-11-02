import Ecto.Query
defmodule TimesheetsWeb.SheetController do
  use TimesheetsWeb, :controller
  

  alias Timesheets.Sheets
  alias Timesheets.Sheets.Sheet
  alias Timesheets.Jobs.Job
  alias Timesheets.Repo
  alias Timesheets.Users

  def index(conn, _params) do
    if (conn.assigns[:current_user].is_manager) do
      workers = Users.get_manager_email(conn.assigns[:current_user].email)
      timesheets = Enum.concat(Enum.map(workers, fn x->Sheets.get_sheet_by_user(x.id) end))
      render(conn, "index.html", timesheets: timesheets)
    else
      timesheets = Sheets.get_sheet_by_user(conn.assigns[:current_user].id)
      render(conn, "index.html", timesheets: timesheets)

    end
  end

  def new(conn, _params) do


    query = from job in Timesheets.Jobs.Job, select: job.jobcode
    changeset = Sheets.change_sheet(%Sheet{tasks: List.duplicate(%Timesheets.Tasks.Task{}, 8)})
    


    jobList = Repo.all(query)
    render(conn, "new.html", changeset: changeset, jobList: jobList)
  end

  def create(conn, %{"sheet" => timesheets}) do
    timesheets = Map.put(timesheets, "worker_id", conn.assigns[:current_user].id)
    query = from job in Timesheets.Jobs.Job, select: job.jobcode
    jobList = Repo.all(query)
    case Sheets.create_sheet(timesheets) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
	|> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, jobList: jobList)
    end
  end

  def show(conn, %{"id" => id}) do
    timesheets = Sheets.get_sheet!(id)
    stid = timesheets.id
    tasks = Timesheets.Tasks.get_tasks_by_sheet_id(stid)
    render(conn, "show.html", timesheets: timesheets, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    timesheets = Sheets.get_sheet!(id)
    query = from job in Timesheets.Jobs.Job, select: job.jobcode
    jobList = Repo.all(query)
    changeset = Sheets.change_sheet(timesheets)
    render(conn, "edit.html", timesheets: timesheets, changeset: changeset, jobList: jobList)
  end

  def update(conn, %{"id" => id, "sheet" => timesheets}) do
    sheet = Sheets.get_sheet!(id)

    case Sheets.update_sheet(sheet, timesheets) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    {:ok, _sheet} = Sheets.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
