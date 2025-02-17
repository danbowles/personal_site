defmodule Mix.Tasks.Build do
  use Mix.Task
  @impl Mix.Task

  @shortdoc "Builds the HTML for the site 🎉"
  def run(_) do
    {micro, :ok} = :timer.tc(fn -> PersonalSite.build() end)

    ms = micro / 1000

    IO.puts("💪 Built site in ⌚#{ms}ms")
  end
end
