defmodule Snjnlsn.Songwriter.Song.Transformer do
  def randomize_lines(text),
    do:
      text
      |> String.downcase()
      |> String.split("\n")
      |> Enum.shuffle()
      |> Enum.join("\n")
      |> IO.puts()
end
