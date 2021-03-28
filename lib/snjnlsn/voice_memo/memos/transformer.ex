defmodule Snjnlsn.VoiceMemo.Song.Transformer do
  def randomize_lines(text),
    do:
      text
      |> String.split("\n")
      |> Enum.shuffle()
      |> Enum.join("\n")
end
