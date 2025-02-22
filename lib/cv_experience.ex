defmodule PersonalSite.CvExperience do
  @enforce_keys [
    :id,
    :company,
    :title,
    :start_date,
    :end_date,
    :location,
    :description,
    :tools,
    :url
  ]
  defstruct [
    :id,
    :company,
    :title,
    :start_date,
    :end_date,
    :location,
    :description,
    :tools,
    :url
  ]

  def build(filename, attrs, body) do
    path = Path.relative_to(filename, :code.priv_dir(:personal_site))
    id = path |> Path.split() |> Enum.take(-1) |> Enum.at(0) |> String.split(".") |> Enum.at(0)
    start_date = attrs[:start_date] |> Date.from_iso8601!()
    end_date = attrs[:end_date] |> Date.from_iso8601!()
    tools = attrs[:tools] |> Enum.join("<span class='text-slate-400'> · </span>")

    struct!(
      __MODULE__,
      Map.to_list(attrs) ++
        [id: id, start_date: start_date, end_date: end_date, description: body, tools: tools]
    )
  end
end
