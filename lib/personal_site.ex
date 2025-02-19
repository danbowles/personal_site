defmodule PersonalSite do
  alias PersonalSite.Blog
  use Phoenix.Component
  import Phoenix.HTML

  @output_dir "./output"

  def head(assigns) do
    ~H"""
    <head>
      <title>Dan's Personal Website</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="The Personal Website of Dan Bowles">
      <meta name="author" content="Dan Bowles">
      <link rel="stylesheet" href="/assets/app.css" />
      <script type="text/javascript" src="/assets/app.js"></script>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
      <!-- Open Graph (for social sharing) -->
      <meta property="og:title" content="The Personal Website of Dan Bowles">
      <meta property="og:description" content="A mix of content, ramblings and thoughts from Dan Bowles">
      <%!-- <meta property="og:image" content="https://example.com/your-image.jpg"> --%>
      <meta property="og:url" content="https://danbowles.com/">
      <meta property="og:type" content="website">
    </head>
    """
  end

  def post(assigns) do
    ~H"""
    <.layout>
      {raw @post.body}
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <%!-- <h2>Posts!</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}>{ post.title }</a>
        </li>
      </ul> --%>
      <p class="text-center">🚧 Still some work to be done!</p>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <.head />
      <body class="font-sans bg-slate-100 text-slate-900">
        <div class="max-w-2xl mx-auto">
          <div class="bg-white border-x-2 border-slate-200 w-full">
            <div class="px-16">
              <div class="flex-col min-h-screen">
                <%!-- HEADER --%>
                <header class="text-center pt-14">
                  <%!-- Intro --%>
                  <div class="mb-10">
                    <img class="rounded-full mb-4 inline-flex" src="/assets/images/danbowles-square-64.jpg" width="48" height="48" alt="Dan Bowles">
                    <div class="mb-5">
                      <h1 class="text-xl font-bold mb-1">Dan Bowles</h1>
                      <p class="text-sm">Engineer of Software, LEGO and puns from Burlington, Vermont</p>
                    </div>
                    <a class="inline-flex bg-slate-800 text-slate-50 rounded-full px-4 py-2" href="https://linkedin.com/in/danpb" target="_blank">Connect With Me</a>
                  </div>
                </header>
                <main class="py-8">
                  {render_slot(@inner_block)}
                </main>
              </div>
            </div>
          </div>
        </div>
      </body>
    </html>
    """
  end

  def build() do
    File.mkdir_p!(@output_dir)
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
