defmodule Snjnlsn.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :name, :string
      add :body, :string

      timestamps()
    end
  end
end
