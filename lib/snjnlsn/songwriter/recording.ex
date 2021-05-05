defmodule Snjnlsn.Songwriter.Recording do
  use Ecto.Schema
  import Ecto.Changeset
  alias Snjnlsn.Repo

  schema "recordings" do
    field :uri, :string
    field :name, :string
    belongs_to :song, Snjnlsn.Songwriter.Song

    timestamps()
  end

  def recording_filename(%{name: name}) do
    # todo: make this a changeset validation
    "#{name |> String.replace(" ", "_")}_#{DateTime.utc_now() |> DateTime.to_string()}"
    |> Zarex.sanitize()
  end

  def recording_filename(_unmatched) do
    # todo: make this a changeset validation
    "#{DateTime.utc_now() |> DateTime.to_string()}"
    |> Zarex.sanitize()
  end

  def save(map) do
    filename = recording_filename(map)
    {:ok, filepath} = write_temp_audio(map, filename)
    {:ok, %{name: name}} = upload_audio(filepath, filename)
    {:ok, result} = insert_to_repo(name)
    {:ok, _dont_care} = File.rm_rf(filepath)
    {:ok, result}
  end

  defp insert_to_repo(name) do
    changeset(%__MODULE__{}, %{
      name: name
    })
    |> Repo.insert()
  end

  def upload_audio(local_path, name) do
    {:ok, t} = Goth.fetch(Snjnlsn.Goth)
    conn = GoogleApi.Storage.V1.Connection.new(t.token)
    {:ok, env} = Application.fetch_env(:snjnlsn, __MODULE__)

    GoogleApi.Storage.V1.Api.Objects.storage_objects_insert_simple(
      conn,
      env[:gcs_bucket_id],
      "multipart",
      %{name: name},
      local_path
    )
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  defp write_temp_audio(%{"mimeType" => "audio/webm", "data" => data}, filename) do
    IO.inspect(data, label: "\n\n data \n\n")
    "data:audio/webm;base64," <> raw = data
    File.write!("./assets/audio/#{filename}.webm", Base.decode64!(raw))
    {:ok, "./assets/audio/#{filename}.webm"}
  end

  defp write_temp_audio(%{"mimeType" => "audio/mp4", "data" => data}, filename) do
    "data:audio/mp4;base64," <> raw = data
    File.write!("./assets/audio/#{filename}.mp4", Base.decode64!(raw))
    {:ok, "./assets/audio/#{filename}.mp4"}
  end
end
