defmodule MapexWeb.EstablishmentsLive.FormComponent do
  use MapexWeb, :live_component

  alias Mapex.FoodPermits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage establishments records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="establishments-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:objectid]} type="number" label="Objectid" />
        <.input field={@form[:applicant]} type="text" label="Applicant" />
        <.input field={@form[:facilitytype]} type="text" label="Facilitytype" />
        <.input field={@form[:locationdescription]} type="text" label="Locationdescription" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:permit]} type="text" label="Permit" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:fooditems]} type="text" label="Fooditems" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Establishments</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{establishments: establishments} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FoodPermits.change_establishments(establishments))
     end)}
  end

  @impl true
  def handle_event("validate", %{"establishments" => establishments_params}, socket) do
    changeset = FoodPermits.change_establishments(socket.assigns.establishments, establishments_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"establishments" => establishments_params}, socket) do
    save_establishments(socket, socket.assigns.action, establishments_params)
  end

  defp save_establishments(socket, :edit, establishments_params) do
    case FoodPermits.update_establishments(socket.assigns.establishments, establishments_params) do
      {:ok, establishments} ->
        notify_parent({:saved, establishments})

        {:noreply,
         socket
         |> put_flash(:info, "Establishments updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_establishments(socket, :new, establishments_params) do
    case FoodPermits.create_establishments(establishments_params) do
      {:ok, establishments} ->
        notify_parent({:saved, establishments})

        {:noreply,
         socket
         |> put_flash(:info, "Establishments created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
