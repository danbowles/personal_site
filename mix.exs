defmodule PersonalSite.MixProject do
  use Mix.Project

  def project do
    [
      app: :personal_site,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_publisher, "~> 1.0.0"},
      {:phoenix_live_view, "~> 1.0"},
      {:esbuild, "~> 0.9.0"},
      {:tailwind, "~> 0.2.4"}
    ]
  end

  defp aliases do
    [
      "site.build": ["build", "tailwind default --minify", "esbuild default --minify"]
    ]
  end
end
