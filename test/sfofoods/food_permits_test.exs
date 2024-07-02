defmodule Mapex.FoodPermitsTest do
  use Mapex.DataCase

  alias Mapex.FoodPermits

  describe "food_vendors" do
    alias Mapex.FoodPermits.Establishments

    import Mapex.FoodPermitsFixtures

    @invalid_attrs %{status: nil, address: nil, permit: nil, objectid: nil, applicant: nil, facilitytype: nil, locationdescription: nil, fooditems: nil, latitude: nil, longitude: nil}

    test "list_food_vendors/0 returns all food_vendors" do
      establishments = establishments_fixture()
      assert FoodPermits.list_food_vendors() == [establishments]
    end

    test "get_establishments!/1 returns the establishments with given id" do
      establishments = establishments_fixture()
      assert FoodPermits.get_establishments!(establishments.id) == establishments
    end

    test "create_establishments/1 with valid data creates a establishments" do
      valid_attrs = %{status: "some status", address: "some address", permit: "some permit", objectid: 42, applicant: "some applicant", facilitytype: "some facilitytype", locationdescription: "some locationdescription", fooditems: "some fooditems", latitude: 120.5, longitude: 120.5}

      assert {:ok, %Establishments{} = establishments} = FoodPermits.create_establishments(valid_attrs)
      assert establishments.status == "some status"
      assert establishments.address == "some address"
      assert establishments.permit == "some permit"
      assert establishments.objectid == 42
      assert establishments.applicant == "some applicant"
      assert establishments.facilitytype == "some facilitytype"
      assert establishments.locationdescription == "some locationdescription"
      assert establishments.fooditems == "some fooditems"
      assert establishments.latitude == 120.5
      assert establishments.longitude == 120.5
    end

    test "create_establishments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodPermits.create_establishments(@invalid_attrs)
    end

    test "update_establishments/2 with valid data updates the establishments" do
      establishments = establishments_fixture()
      update_attrs = %{status: "some updated status", address: "some updated address", permit: "some updated permit", objectid: 43, applicant: "some updated applicant", facilitytype: "some updated facilitytype", locationdescription: "some updated locationdescription", fooditems: "some updated fooditems", latitude: 456.7, longitude: 456.7}

      assert {:ok, %Establishments{} = establishments} = FoodPermits.update_establishments(establishments, update_attrs)
      assert establishments.status == "some updated status"
      assert establishments.address == "some updated address"
      assert establishments.permit == "some updated permit"
      assert establishments.objectid == 43
      assert establishments.applicant == "some updated applicant"
      assert establishments.facilitytype == "some updated facilitytype"
      assert establishments.locationdescription == "some updated locationdescription"
      assert establishments.fooditems == "some updated fooditems"
      assert establishments.latitude == 456.7
      assert establishments.longitude == 456.7
    end

    test "update_establishments/2 with invalid data returns error changeset" do
      establishments = establishments_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodPermits.update_establishments(establishments, @invalid_attrs)
      assert establishments == FoodPermits.get_establishments!(establishments.id)
    end

    test "delete_establishments/1 deletes the establishments" do
      establishments = establishments_fixture()
      assert {:ok, %Establishments{}} = FoodPermits.delete_establishments(establishments)
      assert_raise Ecto.NoResultsError, fn -> FoodPermits.get_establishments!(establishments.id) end
    end

    test "change_establishments/1 returns a establishments changeset" do
      establishments = establishments_fixture()
      assert %Ecto.Changeset{} = FoodPermits.change_establishments(establishments)
    end
  end
end
