defmodule Tvirus.Player.Survivor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survivors" do
    field :age, :integer
    field :gender, :string
    field :infected, :boolean, default: false
    field :name, :string
    field :latitude, :string
    field :longitude, :string
    field :flag, EctoMapSet, of: :integer, default: MapSet.new

    timestamps()
  end

  @doc false
  def changeset(survivor, attrs) do
    survivor
    |> cast(attrs, [:name, :age, :gender, :infected, :latitude, :longitude])
    |> validate_required([:name, :age, :gender])
    |> validate_number(:age, greater_than_or_equal_to: 18)
  end
end
