defmodule Snjnlsn.Songwriter.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  def post_audio(%{"name" => name} = map) do
    filename =
      "#{name |> String.replace(" ", "_")}_#{DateTime.utc_now() |> DateTime.to_string()}"
      |> Zarex.sanitize()

    {:ok, filename_with_ext} = write_temp_audio(map, filename)
    # upload file
    # create record in database
    # delete temporary file
  end

  def write_temp_audio(%{"mimeType" => "audio/webm", "data" => data}, filename) do
    "data:audio/webm;base64" <> raw = data
    File.write!("#{filename}.webm", Base.decode64!(raw))
    {:ok, "#{filename}.webm"}
  end

  def write_temp_audio(%{"mimeType" => "audio/mp4", "data" => data}, filename) do
    "data:audio/mp4;base64" <> raw = data
    File.write!("#{filename}.mp4", Base.decode64!(raw))
    {:ok, "#{filename}.mp4"}
  end

  schema "recordings" do
    field :name, :string
    field :uri, :string
    belongs_to :song, Snjnlsn.Songwriter.Song

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:name, :uri])
    |> validate_required([:name])
  end
end
