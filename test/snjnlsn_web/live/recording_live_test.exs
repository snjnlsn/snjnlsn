defmodule SnjnlsnWeb.RecordingLiveTest do
  use SnjnlsnWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Snjnlsn.Songwriter

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:recording) do
    {:ok, recording} = VoiceMemo.create_recording(@create_attrs)
    recording
  end

  defp create_recording(_) do
    recording = fixture(:recording)
    %{recording: recording}
  end

  describe "Index" do
    setup [:create_recording]

    test "lists all recordings", %{conn: conn, recording: recording} do
      {:ok, _index_live, html} = live(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Listing Recordings"
      assert html =~ recording.name
    end

    test "saves new recording", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("a", "New Recording") |> render_click() =~
               "New Recording"

      assert_patch(index_live, Routes.recording_index_path(conn, :new))

      assert index_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#recording-form", recording: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Recording created successfully"
      assert html =~ "some name"
    end

    test "updates recording in listing", %{conn: conn, recording: recording} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("#recording-#{recording.id} a", "Edit") |> render_click() =~
               "Edit Recording"

      assert_patch(index_live, Routes.recording_index_path(conn, :edit, recording))

      assert index_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#recording-form", recording: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Recording updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes recording in listing", %{conn: conn, recording: recording} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("#recording-#{recording.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#recording-#{recording.id}")
    end
  end

  describe "Show" do
    setup [:create_recording]

    test "displays recording", %{conn: conn, recording: recording} do
      {:ok, _show_live, html} = live(conn, Routes.recording_show_path(conn, :show, recording))

      assert html =~ "Show Recording"
      assert html =~ recording.name
    end

    test "updates recording within modal", %{conn: conn, recording: recording} do
      {:ok, show_live, _html} = live(conn, Routes.recording_show_path(conn, :show, recording))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Recording"

      assert_patch(show_live, Routes.recording_show_path(conn, :edit, recording))

      assert show_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#recording-form", recording: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_show_path(conn, :show, recording))

      assert html =~ "Recording updated successfully"
      assert html =~ "some updated name"
    end
  end
end
