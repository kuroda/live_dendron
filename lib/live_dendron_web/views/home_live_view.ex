defmodule LiveDendronWeb.HomeLiveView do
  use LiveDendronWeb, :view

  def fa_icon(name) do
    Phoenix.HTML.Tag.content_tag(:i, "", class: "fa fa-#{name}")
  end

  def render_node(node) do
    cond do
      node.changeset ->
        render("name_editor.html", changeset: node.changeset, uuid: node.uuid)

      node.in_trash ->
        render("node_in_trash.html", node: node)

      true ->
        render("normal_node.html", node: node)
    end
  end
end
