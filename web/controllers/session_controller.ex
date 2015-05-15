defmodule Phitter.SessionController do
  use Phitter.Web, :controller

  plug :scrub_params, "user" when action in [:create]
  plug :action

  def new(conn, _params) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    Repo.get_by(User, username: user_params["username"])
      |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _) do
    delete_session(conn, :current_user)
      |> put_flash(:info, 'You have been logged out')
      |> redirect(to: session_path(conn, :new))
  end

  defp sign_in(user, password, conn) when is_nil(user) do
    conn
      |> put_flash(:error, 'Could not find a user with that username.')
      |> render "new.html", changeset: User.changeset(%User{})
  end

  defp sign_in(user, password, conn) when is_map(user) do
    cond do
      Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        conn
          |> put_session(:current_user, user)
          |> put_flash(:info, 'You are now signed in.')
          |> redirect(to: pheet_path(conn, :index))
      true ->
        conn
          |> put_flash(:error, 'Username or password are incorrect.')
          |> render "new.html", changeset: User.changeset(%User{})
    end
  end
end
