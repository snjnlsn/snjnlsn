defmodule SnjnlsnWeb.RecordingLive.Index do
  use SnjnlsnWeb, :live_view

  alias Snjnlsn.VoiceMemo
  alias Snjnlsn.VoiceMemo.Recording

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
    |> assign(:recording, VoiceMemo.get_recording!(id))
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
    recording = VoiceMemo.get_recording!(id)
    {:ok, _} = VoiceMemo.delete_recording(recording)

    {:noreply, assign(socket, :recordings, list_recordings())}
  end

  def handle_event("send-to-phx", params, socket) do
    IO.inspect(params, label: "test")
    {:noreply, push_event(socket, "record", %{valueMagic: "magicValue!"})}
  end

  def handle_event("recieved", params, socket) do
    IO.inspect(params, label: "received")
    {:noreply, socket}
  end

  def handle_event("done", params, socket) do
    IO.inspect(params, label: "test")
    {:noreply, socket}
  end

  def handle_event("cannot-record", params, socket) do
    IO.inspect(params, label: "its so sad but honestly we cannot record")
    {:noreply, socket}
  end

  defp list_recordings do
    VoiceMemo.list_recordings()
  end
end
