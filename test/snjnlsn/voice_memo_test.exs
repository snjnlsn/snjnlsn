defmodule Snjnlsn.SongwriterTest do
  use Snjnlsn.DataCase

  alias Snjnlsn.Songwriter

  describe "recordings" do
    alias Snjnlsn.Songwriter.Recording

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def recording_fixture(attrs \\ %{}) do
      {:ok, recording} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Songwriter.create_recording()

      recording
    end

    test "list_recordings/0 returns all recordings" do
      recording = recording_fixture()
      assert Songwriter.list_recordings() == [recording]
    end

    test "get_recording!/1 returns the recording with given id" do
      recording = recording_fixture()
      assert Songwriter.get_recording!(recording.id) == recording
    end

    test "create_recording/1 with valid data creates a recording" do
      assert {:ok, %Recording{} = recording} = Songwriter.create_recording(@valid_attrs)
      assert recording.name == "some name"
    end

    test "create_recording/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Songwriter.create_recording(@invalid_attrs)
    end

    test "update_recording/2 with valid data updates the recording" do
      recording = recording_fixture()

      assert {:ok, %Recording{} = recording} =
               Songwriter.update_recording(recording, @update_attrs)

      assert recording.name == "some updated name"
    end

    test "update_recording/2 with invalid data returns error changeset" do
      recording = recording_fixture()
      assert {:error, %Ecto.Changeset{}} = Songwriter.update_recording(recording, @invalid_attrs)
      assert recording == Songwriter.get_recording!(recording.id)
    end

    test "delete_recording/1 deletes the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{}} = Songwriter.delete_recording(recording)
      assert_raise Ecto.NoResultsError, fn -> Songwriter.get_recording!(recording.id) end
    end

    test "change_recording/1 returns a recording changeset" do
      recording = recording_fixture()
      assert %Ecto.Changeset{} = Songwriter.change_recording(recording)
    end
  end
end