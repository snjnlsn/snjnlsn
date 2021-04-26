defmodule Snjnlsn.Songwriter.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do
    field :name, :string
    field :uri, :string
    belongs_to :song, Snjnlsn.Songwriter.Song

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end