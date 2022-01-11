defmodule Tvirus.Repo.Migrations.AddFlagToSurvivors do
  use Ecto.Migration

  def change do
    alter table(:survivors) do
      add(:flag, {:array, :integer})
    end
  end
end
