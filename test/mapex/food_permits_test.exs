defmodule Mapex.FoodPermitsTest do
  use Mapex.DataCase

  alias Mapex.FoodPermits

  describe "vendors" do
    alias Mapex.FoodPermits.Establishment

    import Mapex.FoodPermitsFixtures

    @invalid_attrs %{
      objectid: nil,
      applicant: nil,
      facilitytype: nil,
      locationdescription: nil,
      address: nil,
      permit: nil,
      status: nil,
      fooditems: nil,
      latitude: nil,
      longitude: nil
    }

    test "list_vendors/0 returns all vendors" do
      establishment = establishment_fixture()
      assert FoodPermits.list_vendors() == [establishment]
    end

    test "get_establishment!/1 returns the establishment with given id" do
      establishment = establishment_fixture()
      assert FoodPermits.get_establishment!(establishment.id) == establishment
    end

    test "create_establishment/1 with valid data creates a establishment" do
      valid_attrs = %{
        kind: "some kind",
        permit_status: "some permit_status",
        serving: "some serving"
      }

      assert {:ok, %Establishment{} = establishment} =
               FoodPermits.create_establishment(valid_attrs)

      assert establishment.kind == "some kind"
      assert establishment.permit_status == "some permit_status"
      assert establishment.serving == "some serving"
    end

    test "create_establishment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodPermits.create_establishment(@invalid_attrs)
    end

    test "update_establishment/2 with valid data updates the establishment" do
      establishment = establishment_fixture()

      update_attrs = %{
        kind: "some updated kind",
        permit_status: "some updated permit_status",
        serving: "some updated serving"
      }

      assert {:ok, %Establishment{} = establishment} =
               FoodPermits.update_establishment(establishment, update_attrs)

      assert establishment.kind == "some updated kind"
      assert establishment.permit_status == "some updated permit_status"
      assert establishment.serving == "some updated serving"
    end

    test "update_establishment/2 with invalid data returns error changeset" do
      establishment = establishment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               FoodPermits.update_establishment(establishment, @invalid_attrs)

      assert establishment == FoodPermits.get_establishment!(establishment.id)
    end

    test "delete_establishment/1 deletes the establishment" do
      establishment = establishment_fixture()
      assert {:ok, %Establishment{}} = FoodPermits.delete_establishment(establishment)
      assert_raise Ecto.NoResultsError, fn -> FoodPermits.get_establishment!(establishment.id) end
    end

    test "change_establishment/1 returns a establishment changeset" do
      establishment = establishment_fixture()
      assert %Ecto.Changeset{} = FoodPermits.change_establishment(establishment)
    end
  end
end
