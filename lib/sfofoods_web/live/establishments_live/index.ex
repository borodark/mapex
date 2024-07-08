defmodule MapexWeb.EstablishmentsLive.Index do
  use MapexWeb, :live_view

  alias Mapex.FoodPermits
  alias Mapex.FoodPermits.Establishment
  @impl true
  def mount(_params, _session, socket) do
    "calling mount ....." |> IO.inspect()

    {:ok,
     socket
     |> assign(
       :form,
       Establishment.changeset(%Establishment{}, %{fooditems: "Taco", status: "APPROVED"})
       |> to_form
     )
     |> stream(:food_vendors, FoodPermits.list_food_vendors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
     apply_action(
       socket,
       socket.assigns.live_action,
       params
     )}
  end

  @impl true
  def handle_event("validate", params, socket) do
    # at least 3 chars for search
    search_form = %Establishment{} |> Establishment.changeset(params)

    case search_form.valid? do
      true ->
        {:noreply, socket |> assign(form: to_form(params))}

      false ->
        errors = search_form.errors
        {:noreply, socket |> assign(form: to_form(params, errors: errors))}
    end
  end

  @impl true
  def handle_event("search", %{"food" => food_item, "status" => _permit_status} = params, socket) do
    {:noreply,
     socket |> stream(:food_vendors, FoodPermits.search_vendors_serving(food_item), reset: true)}
  end

  defp apply_action(socket, :index, _params) do
    # "calling apply_action" |> IO.inspect
    socket
    |> assign(:page_title, "Food vendors of Saint Francisco")
  end
end
