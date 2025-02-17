defmodule PersonalSite do
  alias PersonalSite.Blog
  use Phoenix.Component
  import Phoenix.HTML

  @output_dir "./output"
  File.mkdir_p!(@output_dir)

  def post(assigns) do
    ~H"""
    <.layout>
      {raw @post.body}
    </.layout>
    """
  end

  @spec index(any()) :: Phoenix.LiveView.Rendered.t()
  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Jason's Personal website!!</h1>
      <h2>Posts!</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}>{ post.title }</a>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <body>
        {render_slot(@inner_block)}/
      </body>
    </html>
    """
  end

  def build() do
    posts = Blog.all_posts()
    tags = Blog.all_tags()

    render_file("index.html", index(%{posts: posts, tags: tags}))

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!("#{@output_dir}/#{dir}")
      end

      render_file(post.path, post(%{post: post}))
    end

    :ok
  end

  defp render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
