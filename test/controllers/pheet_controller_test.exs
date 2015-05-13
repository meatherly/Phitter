defmodule Phitter.PheetControllerTest do
  use Phitter.ConnCase

  alias Phitter.Pheet
  @valid_params pheet: %{body: "some content"}
  @invalid_params pheet: %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "GET /pheets", %{conn: conn} do
    conn = get conn, pheet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing pheets"
  end

  test "GET /pheets/new", %{conn: conn} do
    conn = get conn, pheet_path(conn, :new)
    assert html_response(conn, 200) =~ "New pheet"
  end

  test "POST /pheets with valid data", %{conn: conn} do
    conn = post conn, pheet_path(conn, :create), @valid_params
    assert redirected_to(conn) == pheet_path(conn, :index)
  end

  test "POST /pheets with invalid data", %{conn: conn} do
    conn = post conn, pheet_path(conn, :create), @invalid_params
    assert html_response(conn, 200) =~ "New pheet"
  end

  test "GET /pheets/:id", %{conn: conn} do
    pheet = Repo.insert %Pheet{}
    conn = get conn, pheet_path(conn, :show, pheet)
    assert html_response(conn, 200) =~ "Show pheet"
  end

  test "GET /pheets/:id/edit", %{conn: conn} do
    pheet = Repo.insert %Pheet{}
    conn = get conn, pheet_path(conn, :edit, pheet)
    assert html_response(conn, 200) =~ "Edit pheet"
  end

  test "PUT /pheets/:id with valid data", %{conn: conn} do
    pheet = Repo.insert %Pheet{}
    conn = put conn, pheet_path(conn, :update, pheet), @valid_params
    assert redirected_to(conn) == pheet_path(conn, :index)
  end

  test "PUT /pheets/:id with invalid data", %{conn: conn} do
    pheet = Repo.insert %Pheet{}
    conn = put conn, pheet_path(conn, :update, pheet), @invalid_params
    assert html_response(conn, 200) =~ "Edit pheet"
  end

  test "DELETE /pheets/:id", %{conn: conn} do
    pheet = Repo.insert %Pheet{}
    conn = delete conn, pheet_path(conn, :delete, pheet)
    assert redirected_to(conn) == pheet_path(conn, :index)
    refute Repo.get(Pheet, pheet.id)
  end
end
