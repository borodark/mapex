defmodule Mapex.FoodPermitsTest do
  use Mapex.DataCase

  alias Mapex.FoodPermits

  describe "food_vendors" do
    import Mapex.FoodPermitsFixtures

    test "list_food_vendors/0 returns all food_vendors" do
      establishments = establishments_fixture()
      assert FoodPermits.list_food_vendors() == [establishments]
    end

    test "get_establishments!/1 returns the establishments with given id" do
      establishments = establishments_fixture()
      assert FoodPermits.get_establishment!(establishments.id) == establishments
    end
  end
end
