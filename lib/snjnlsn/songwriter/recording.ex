defmodule Snjnlsn.Songwriter.Recording do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snjnlsn.Repo

  schema "recordings" do
    field :name, :string
    field :uri, :string
    belongs_to :song, Snjnlsn.Songwriter.Song

    timestamps()
  end

  def save(%{"name" => name} = map) do
    filename =
      "#{name |> String.replace(" ", "_")}_#{DateTime.utc_now() |> DateTime.to_string()}"
      |> Zarex.sanitize()

    {:ok, filepath} = write_temp_audio(map, filename)

    {:ok, obj} = upload_audio(filepath, filename)

    {:ok, _result} = insert_to_repo(obj[:name], name)

    File.rm_rf(filepath)
  end

  defp insert_to_repo(gcs_name, name) do
    changeset(%__MODULE__{}, %{
      gcs_name: gcs_name,
      name: name
    })
    |> Repo.insert()
  end

  defp upload_audio(filepath, filename) do
    {:ok, t} = Goth.fetch(Snjnlsn.Goth)
    conn = GoogleApi.Storage.V1.Connection.new(t.token)
    {:ok, env} = Application.fetch_env(:snjnlsn, __MODULE__)

    GoogleApi.Storage.V1.Api.Objects.storage_objects_insert_simple(
      conn,
      env[:gcs_bucket_id],
      "multipart",
      %{name: filename},
      filepath
    )
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:name, :gcs_name])
    |> validate_required([:name])
  end

  defp write_temp_audio(%{"mimeType" => "audio/webm", "data" => data}, filename) do
    "data:audio/webm;base64" <> raw = data
    File.write!("./assets/audio/#{filename}.webm", Base.decode64!(raw))
    {:ok, "./assets/audio/#{filename}.webm"}
  end

  defp write_temp_audio(%{"mimeType" => "audio/mp4", "data" => data}, filename) do
    "data:audio/mp4;base64" <> raw = data
    File.write!("./assets/audio/#{filename}.mp4", Base.decode64!(raw))
    {:ok, "./assets/audio/#{filename}.mp4"}
  end
end
