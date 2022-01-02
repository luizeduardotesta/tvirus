defmodule Tvirus.Repo.Migrations.CreateSurvivors do
  use Ecto.Migration

  def change do
    create table(:survivors) do
      add :name, :string
      add :age, :integer
      add :gender, :string
      add :infected, :boolean, default: false, null: false

      timestamps()
    end
  end
end
