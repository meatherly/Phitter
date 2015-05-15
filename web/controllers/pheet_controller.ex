defmodule Phitter.PheetController do
  use Phitter.Web, :controller

  alias Phitter.Pheet

  plug Phitter.Plug.Authenticate
  plug :scrub_params, "pheet" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    pheets = Repo.all from p in Pheet,
      preload: [:user]
    render(conn, "index.html", pheets: pheets)
  end

  def new(conn, _params) do
    changeset = Pheet.changeset(%Pheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pheet" => pheet_params}) do
    new_pheet = build(conn.assigns.current_user, :pheets)
    changeset = Pheet.changeset(new_pheet, pheet_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Pheet created successfully.")
      |> redirect(to: pheet_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pheet = Repo.get(Pheet, id)
    render(conn, "show.html", pheet: pheet)
  end

  def edit(conn, %{"id" => id}) do
    pheet = Repo.get(Pheet, id)
    changeset = Pheet.changeset(pheet)
    render(conn, "edit.html", pheet: pheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pheet" => pheet_params}) do
    pheet = Repo.get(Pheet, id)
    changeset = Pheet.changeset(pheet, pheet_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Pheet updated successfully.")
      |> redirect(to: pheet_path(conn, :index))
    else
      render(conn, "edit.html", pheet: pheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pheet = Repo.get(Pheet, id)
    Repo.delete(pheet)

    conn
    |> put_flash(:info, "Pheet deleted successfully.")
    |> redirect(to: pheet_path(conn, :index))
  end
end
