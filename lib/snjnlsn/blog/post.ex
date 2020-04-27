defmodule Snjnlsn.Blog.Post do
  @enforce_keys [:id, :author, :title, :body, :description, :date]
  defstruct [:id, :author, :title, :body, :description, :date]
  require IEx

  def parse!(filename) do
    [year, month_day_id] = filename |> Path.split() |> Enum.take(-2)

    [month, day, id_with_md] = String.split(month_day_id, "-", parts: 3)

    id = Path.rootname(id_with_md)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    contents = parse_contents(id, File.read!(filename))

    struct!(__MODULE__, [id: id, date: date] ++ contents)
  end

  defp parse_contents(id, contents) do
    parts = Regex.split(~r/^==(\w+)==\n/m, contents, include_captures: true, trim: true)
    for [attr_unformatted, val] <- Enum.chunk_every(parts, 2) do
      [_, attr, _] = String.split(attr_unformatted, "==")
      attr = String.to_atom(attr)
      {attr, parse_attr(attr, val)}
    end
  end

  defp parse_attr(:body, val), do: Earmark.as_html(val)

  defp parse_attr(_attr, val), do: String.trim(val)
end
