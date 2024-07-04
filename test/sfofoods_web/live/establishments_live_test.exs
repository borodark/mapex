defmodule MapexWeb.EstablishmentsLiveTest do
  use MapexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mapex.FoodPermitsFixtures

  @create_attrs %{
    status: "some status",
    address: "some address",
    permit: "some permit",
    applicant: "some applicant",
    facilitytype: "some facilitytype",
    locationdescription: "some locationdescription",
    fooditems: "some fooditems",
    latitude: 120.5,
    longitude: 120.5
  }

  defp create_establishments(_) do
    establishments = establishments_fixture()
    %{establishments: establishments}
  end

  describe "Index" do
    setup [:create_establishments]

    test "lists all food_vendors", %{conn: conn, establishments: establishments} do
      {:ok, _index_live, html} = live(conn, ~p"/food_vendors")

      assert html =~ "Listing Food vendors"
      assert html =~ establishments.status
    end
  end

  describe "Show" do
    setup [:create_establishments]

    test "displays establishments", %{conn: conn, establishments: establishments} do
      {:ok, _show_live, html} = live(conn, ~p"/food_vendors/#{establishments}")

      assert html =~ "Show Establishments"
      assert html =~ establishments.status
    end

    test "updates establishments within modal", %{conn: conn, establishments: establishments} do
      {:ok, show_live, _html} = live(conn, ~p"/food_vendors/#{establishments}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Establishments"

      assert_patch(show_live, ~p"/food_vendors/#{establishments}/show/edit")

      assert show_live
             |> form("#establishments-form", establishments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#establishments-form", establishments: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/food_vendors/#{establishments}")

      html = render(show_live)
      assert html =~ "Establishments updated successfully"
      assert html =~ "some updated status"
    end
  end
end
