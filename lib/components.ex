defmodule PersonalSite.Components do
  use Phoenix.Component
  # import Phoenix.HTML

  def anchor_button(assigns) do
    ~H"""
    <a class="inline-flex bg-gradient-to-r from-purple-400 via-pink-500 to-red-500 text-slate-700 rounded-full px-4 py-2 transition duration-300 ease-in-out transform hover:scale-105 hover:from-purple-500 hover:via-pink-600 hover:to-red-600" href={@href} target="_blank">{@text}</a>
    """
  end
end
