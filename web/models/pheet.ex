defmodule Phitter.Pheet do
  use Phitter.Web, :model

  schema "pheets" do
    belongs_to :user, Phitter.User
    field :body, :string

    timestamps
  end

  @required_fields ~w(body user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
