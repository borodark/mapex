defmodule MapexWeb.EstablishmentLiveTest do
  use MapexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mapex.FoodPermitsFixtures

  @create_attrs %{kind: "some kind", permit_status: "some permit_status", serving: "some serving"}
  @update_attrs %{
    kind: "some updated kind",
    permit_status: "some updated permit_status",
    serving: "some updated serving"
  }
  @invalid_attrs %{kind: nil, permit_status: nil, serving: nil}

  defp create_establishment(_) do
    establishment = establishment_fixture()
    %{establishment: establishment}
  end

  describe "Index" do
    setup [:create_establishment]

    test "lists all vendors", %{conn: conn, establishment: establishment} do
      {:ok, _index_live, html} = live(conn, ~p"/vendors")

      assert html =~ "Listing Vendors"
      assert html =~ establishment.kind
    end
  end

  describe "Show" do
    setup [:create_establishment]

    test "displays establishment", %{conn: conn, establishment: establishment} do
      {:ok, _show_live, html} = live(conn, ~p"/vendors/#{establishment}")

      assert html =~ "Show Establishment"
      assert html =~ establishment.kind
    end

    test "updates establishment within modal", %{conn: conn, establishment: establishment} do
      {:ok, show_live, _html} = live(conn, ~p"/vendors/#{establishment}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Establishment"

      assert_patch(show_live, ~p"/vendors/#{establishment}/show/edit")

      assert show_live
             |> form("#establishment-form", establishment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#establishment-form", establishment: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vendors/#{establishment}")

      html = render(show_live)
      assert html =~ "Establishment updated successfully"
      assert html =~ "some updated kind"
    end
  end
end
