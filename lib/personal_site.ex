defmodule PersonalSite do
  # alias PersonalSite.Components
  alias PersonalSite.Blog
  use Phoenix.Component
  import Phoenix.HTML

  @output_dir "./output"

  def anchor_button(assigns) do
    ~H"""
    <a class="inline-flex bg-gradient-to-r from-slate-600 to-slate-800 text-white font-semibold rounded-full px-4 py-2" href={@href} target="_blank">{@text}</a>
    """
  end

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
      <!-- Open Graph (for social sharing) -->
      <meta property="og:title" content="The Personal Website of Dan Bowles">
      <meta property="og:description" content="A mix of content, ramblings and thoughts from Dan Bowles">
      <%!-- <meta property="og:image" content="https://example.com/your-image.jpg"> --%>
      <meta property="og:url" content="https://danbowles.com/">
      <meta property="og:type" content="website">
      <!-- Favicon & App Icons -->
      <%!-- <link rel="icon" href="/favicon.ico">
      <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
      <link rel="manifest" href="/site.webmanifest"> --%>
      <!-- Security & Performance -->
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
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

  def section(assigns) do
    ~H"""
    <section>
      <h2 class="text-xl font-bold mb-6">{@title}</h2>
      <div>
        {render_slot(@inner_block)}
      </div>
    </section>
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
      <.section title="Experience">
        <p>Coming soon!</p>
      </.section>
      <.section title="Projects">
        <p>Coming soon!</p>
      </.section>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <.head />
      <body class="font-sans bg-slate-100 text-slate-900">
        <div class="overflow-clip">
        <div class="max-w-2xl mx-auto">
          <div class="bg-white border-x-2 border-slate-200 w-full">
            <div class="px-16">
              <div class="flex-col min-h-screen">
                <%!-- HEADER --%>
                <header class="text-center pt-14">
                  <%!-- Intro --%>
                  <div class="mb-12">
                    <img class="rounded-full mb-4 inline-flex" src="/assets/images/danbowles-square-64.jpg" width="48" height="48" alt="Dan Bowles">
                    <div class="mb-5">
                      <h1 class="text-2xl font-bold mb-2">Dan Bowles</h1>
                      <p>
                        Software Engineer and LEGO fan from Vermont 🇺🇸
                      </p>
                    </div>
                    <.anchor_button href="https://linkedin.com/in/danpb" text="Connect With Me"/>
                  </div>
                  <%!-- Images --%>
                  <div class="gap-4 justify-center flex">
                    <%= for i <- 1..3 do %>
                      <img
                        class="shadow-lg rounded-lg odd:-rotate-3 even:rotate-3"
                        src={"/assets/images/header_#{i}_sm.jpg"}
                        width="240"
                        height="160"
                        alt="Dan Bowles"
                      />
                    <% end %>
                  </div>
                </header>
                <main class="py-12 space-y-16">
                  {render_slot(@inner_block)}
                </main>
              </div>
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
