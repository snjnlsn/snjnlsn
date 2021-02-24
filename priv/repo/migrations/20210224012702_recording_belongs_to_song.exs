defmodule Snjnlsn.Repo.Migrations.RecordingBelongsToSong do
  use Ecto.Migration

  def change do
    alter table(:recordings) do
      add :uri, :string
      add :song_id, references(:songs)
    end
  end
end
