defmodule SnjnlsnWeb.RecordingLive.FormComponent do
  use SnjnlsnWeb, :live_component

  alias Snjnlsn.Songwriter

  @impl true
  def update(%{recording: recording} = assigns, socket) do
    changeset = VoiceMemo.change_recording(recording)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"recording" => recording_params}, socket) do
    changeset =
      socket.assigns.recording
      |> VoiceMemo.change_recording(recording_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"recording" => recording_params}, socket) do
    save_recording(socket, socket.assigns.action, recording_params)
  end

  defp save_recording(socket, :edit, recording_params) do
    case VoiceMemo.update_recording(socket.assigns.recording, recording_params) do
      {:ok, _recording} ->
        {:noreply,
         socket
         |> put_flash(:info, "Recording updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_recording(socket, :new, recording_params) do
    case VoiceMemo.create_recording(recording_params) do
      {:ok, _recording} ->
        {:noreply,
         socket
         |> put_flash(:info, "Recording created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
