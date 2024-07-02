defmodule MapexWeb.EstablishmentsLiveTest do
  use MapexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mapex.FoodPermitsFixtures

  @create_attrs %{
    status: "some status",
    address: "some address",
    permit: "some permit",
    objectid: 42,
    applicant: "some applicant",
    facilitytype: "some facilitytype",
    locationdescription: "some locationdescription",
    fooditems: "some fooditems",
    latitude: 120.5,
    longitude: 120.5
  }
  @update_attrs %{
    status: "some updated status",
    address: "some updated address",
    permit: "some updated permit",
    objectid: 43,
    applicant: "some updated applicant",
    facilitytype: "some updated facilitytype",
    locationdescription: "some updated locationdescription",
    fooditems: "some updated fooditems",
    latitude: 456.7,
    longitude: 456.7
  }
  @invalid_attrs %{
    status: nil,
    address: nil,
    permit: nil,
    objectid: nil,
    applicant: nil,
    facilitytype: nil,
    locationdescription: nil,
    fooditems: nil,
    latitude: nil,
    longitude: nil
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

    test "saves new establishments", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/food_vendors")

      assert index_live |> element("a", "New Establishments") |> render_click() =~
               "New Establishments"

      assert_patch(index_live, ~p"/food_vendors/new")

      assert index_live
             |> form("#establishments-form", establishments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#establishments-form", establishments: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_vendors")

      html = render(index_live)
      assert html =~ "Establishments created successfully"
      assert html =~ "some status"
    end

    test "updates establishments in listing", %{conn: conn, establishments: establishments} do
      {:ok, index_live, _html} = live(conn, ~p"/food_vendors")

      assert index_live
             |> element("#food_vendors-#{establishments.id} a", "Edit")
             |> render_click() =~
               "Edit Establishments"

      assert_patch(index_live, ~p"/food_vendors/#{establishments}/edit")

      assert index_live
             |> form("#establishments-form", establishments: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#establishments-form", establishments: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_vendors")

      html = render(index_live)
      assert html =~ "Establishments updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes establishments in listing", %{conn: conn, establishments: establishments} do
      {:ok, index_live, _html} = live(conn, ~p"/food_vendors")

      assert index_live
             |> element("#food_vendors-#{establishments.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#food_vendors-#{establishments.id}")
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
