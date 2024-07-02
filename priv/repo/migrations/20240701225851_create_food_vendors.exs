defmodule Mapex.Repo.Migrations.CreateFoodVendors do
  use Ecto.Migration

  def change do
    create table(:food_vendors) do
      add :objectid, :integer
      add :applicant, :string
      add :facilitytype, :string
      add :locationdescription, :string
      add :address, :string
      add :permit, :string
      add :status, :string
      add :fooditems, :string
      add :latitude, :float
      add :longitude, :float

      timestamps(type: :utc_datetime)
    end
  end
end
