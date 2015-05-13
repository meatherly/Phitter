defmodule Phitter.Repo.Migrations.CreatePheet do
  use Ecto.Migration

  def change do
    create table(:pheets) do
      add :body, :string
      add :user_id, references(:users)


      timestamps
    end
    create index(:pheets, [:user_id])
  end
end
