defmodule Phitter.User do
  use Phitter.Web, :model

  schema "users" do
    has_many :pheets, Phitter.Pheet
    field :username, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps
  end

  @required_fields ~w(username password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:username, on: Phitter.Repo, downcase: true)
    |> validate_length(:password, min: 1)
    |> validate_length(:password_confirmation, min: 1)
    |> validate_confirmation(:password)
  end

  def validate_confirmation(changeset, field) do
    value = get_field(changeset, field)
    confirmation_value = get_field(changeset, :"#{field}_confirmation")
    if value != confirmation_value, do: add_error(changeset, :"#{field}_confirmation", "does not match"), else: changeset
  end
end
