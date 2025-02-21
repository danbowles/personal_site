import Config

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(app.js --bundle --target=es2017 --outdir=../output/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.0.7",
  default: [
    args: ~w(
      --input=css/app.css
      --output=../output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
