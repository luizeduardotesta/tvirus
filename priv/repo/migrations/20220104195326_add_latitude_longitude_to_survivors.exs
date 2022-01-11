defmodule Tvirus.Repo.Migrations.AddLatitudeLongitudeToSurvivors do
  use Ecto.Migration

  def change do
    alter table(:survivors) do
      add :latitude, :string
      add :longitude, :string
    end
  end
end
