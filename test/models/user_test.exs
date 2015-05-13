defmodule Phitter.UserTest do
  use Phitter.ModelCase

  alias Phitter.User

  @valid_attrs %{username: "username", password: "password", password_confirmation: "password"}
  @invalid_attrs %{username: "user name", password: "password", password_confirmation: "not the same"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
