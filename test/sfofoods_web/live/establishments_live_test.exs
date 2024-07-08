defmodule MapexWeb.EstablishmentsLiveTest do
  use MapexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mapex.FoodPermitsFixtures

  defp create_establishments(_) do
    establishments = establishments_fixture()
    %{establishments: establishments}
  end

  describe "Index" do
    setup [:create_establishments]

    test "lists all food_vendors", %{conn: conn, establishments: establishments} do
      {:ok, _index_live, html} = live(conn, ~p"/food_vendors")

      assert html =~ "SFO Food Locator"
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
  end
end
