defmodule Phitter.SessionController do
  use Phitter.Web, :controller

  plug :scrub_params, "user" when action in [:create]
  plug :action

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, username: user_params["username"])
    if user do
      conn
        |> put_session(:current_user, user)
        |> redirect(to: pheet_path(conn, :index))
    else
      changeset = User.changeset(%User{})

      conn
        |> put_flash(:error, 'Username or password are incorrect.')
        |> render "new.html", changeset: changeset
    end
  end
end
