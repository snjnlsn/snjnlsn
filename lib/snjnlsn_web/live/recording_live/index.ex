defmodule SnjnlsnWeb.RecordingLive.Index do
  use SnjnlsnWeb, :live_view

  alias Snjnlsn.Songwriter
  alias Snjnlsn.Songwriter
  alias Snjnlsn.Songwriter.Recording

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :recordings, list_recordings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Recording")
    |> assign(:recording, Songwriter.get_recording!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Recording")
    |> assign(:recording, %Recording{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Recordings")
    |> assign(:recording, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    recording = Songwriter.get_recording!(id)
    {:ok, _} = Songwriter.delete_recording(recording)

    {:noreply, assign(socket, :recordings, list_recordings())}
  end

  # def handle_event("send-to-phx", params, socket) do
  #   # IO.inspect(params, label: "test")
  #   {:noreply, push_event(socket, "record", %{valueMagic: "magicValue!"})}
  # end

  def handle_event("recieved", audio_params, socket) do
    # IO.inspect(data, label: "raw")
    # {:ok, stuff} = Songwriter.post_audio(audio_params)
    Songwriter.post_recording(audio_params)

    # "data:audio/mp4;base64," <> raw = data
    # File.write!("audio.mp4", Base.decode64!(raw))
    {:noreply, socket}
  end

  def handle_event("cannot-record", params, socket) do
    IO.inspect(params, label: "its so sad but honestly we cannot record")
    {:noreply, socket}
  end

  defp list_recordings do
    Songwriter.list_recordings()
  end
end
