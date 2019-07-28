defmodule LiveDendronWeb.HomeLiveView do
  use LiveDendronWeb, :view

  def fa_icon(name) do
    Phoenix.HTML.Tag.content_tag(:i, "", class: "fa fa-#{name}")
  end
end
