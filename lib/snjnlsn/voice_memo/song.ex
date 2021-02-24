defmodule Snjnlsn.VoiceMemo.Song do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field :name, :string
    field :body, :string
    has_many :recordings, Snjnlsn.VoiceMemo.Recording

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
