defmodule LiveAdmin.Components.FieldRenderer do
  @moduledoc """
  Default Field Renderer

  Can be overridden with the :renderer option
  """
  use Phoenix.Component


  def field(assigns) do
    ~H"""
    <a class="cell__contents" href="#" >
      <%= print(@contents) %>
    </a>
    """
  end

  defp print(term) when is_binary(term), do: term
  defp print(term), do: inspect(term)
end
