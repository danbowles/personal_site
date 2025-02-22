defmodule PersonalSite.Cv do
  alias PersonalSite.CvExperience

  use NimblePublisher,
    build: CvExperience,
    from: Application.app_dir(:personal_site, "priv/experience/*.md"),
    as: :experience,
    highlighters: []

  @experience Enum.sort_by(@experience, & &1.start_date, {:desc, Date})

  def all_experience, do: @experience
end
