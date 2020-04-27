defmodule Snjnlsn.Blog do
  alias Snjnlsn.Blog.Post

  Application.ensure_all_started(:earmark)

  posts_path = "posts/**/*.md" |> Path.wildcard() |> Enum.sort()

  posts =
    for post_path <- posts_path do
      @external_resource Path.relative_to_cwd(post_path)
      Post.parse!(post_path)
    end

  @posts Enum.sort_by(posts, & &1.date, {:desc, Date})

  def list_posts, do: @posts
end
