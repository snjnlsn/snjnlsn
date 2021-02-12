defmodule Snjnlsn.VoiceMemoTest do
  use Snjnlsn.DataCase

  alias Snjnlsn.VoiceMemo

  describe "recordings" do
    alias Snjnlsn.VoiceMemo.Recording

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def recording_fixture(attrs \\ %{}) do
      {:ok, recording} =
        attrs
        |> Enum.into(@valid_attrs)
        |> VoiceMemo.create_recording()

      recording
    end

    test "list_recordings/0 returns all recordings" do
      recording = recording_fixture()
      assert VoiceMemo.list_recordings() == [recording]
    end

    test "get_recording!/1 returns the recording with given id" do
      recording = recording_fixture()
      assert VoiceMemo.get_recording!(recording.id) == recording
    end

    test "create_recording/1 with valid data creates a recording" do
      assert {:ok, %Recording{} = recording} = VoiceMemo.create_recording(@valid_attrs)
      assert recording.name == "some name"
    end

    test "create_recording/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VoiceMemo.create_recording(@invalid_attrs)
    end

    test "update_recording/2 with valid data updates the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{} = recording} = VoiceMemo.update_recording(recording, @update_attrs)
      assert recording.name == "some updated name"
    end

    test "update_recording/2 with invalid data returns error changeset" do
      recording = recording_fixture()
      assert {:error, %Ecto.Changeset{}} = VoiceMemo.update_recording(recording, @invalid_attrs)
      assert recording == VoiceMemo.get_recording!(recording.id)
    end

    test "delete_recording/1 deletes the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{}} = VoiceMemo.delete_recording(recording)
      assert_raise Ecto.NoResultsError, fn -> VoiceMemo.get_recording!(recording.id) end
    end

    test "change_recording/1 returns a recording changeset" do
      recording = recording_fixture()
      assert %Ecto.Changeset{} = VoiceMemo.change_recording(recording)
    end
  end
end
