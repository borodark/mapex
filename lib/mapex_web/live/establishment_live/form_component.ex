defmodule MapexWeb.EstablishmentLive.FormComponent do
  use MapexWeb, :live_component

  alias Mapex.FoodPermits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage establishment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="establishment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:kind]} type="text" label="Kind" />
        <.input field={@form[:permit_status]} type="text" label="Permit status" />
        <.input field={@form[:serving]} type="text" label="Serving" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Establishment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
