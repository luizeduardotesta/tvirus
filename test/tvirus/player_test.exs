defmodule Tvirus.PlayerTest do
  use Tvirus.DataCase

  import Tvirus.Factory

  alias Tvirus.Player

  describe "survivors" do
    alias Tvirus.Player.Survivor

    @invalid_attrs %{age: nil, gender: nil, infected: nil, name: nil}

    test "list_survivors/0 returns all survivors" do
      survivor = insert(:survivor)
      assert Player.list_survivors() == [survivor]
    end

    test "get_survivor/1 returns the survivor with given id" do
      survivor = insert(:survivor)
      assert Player.get_survivor(survivor.id) == survivor
    end

    test "create_survivor/1 with valid data creates a survivor" do
      valid_attrs = params_for(:survivor)

      assert {:ok, %Survivor{} = survivor} = Player.create_survivor(valid_attrs)
      assert survivor.age == valid_attrs.age
      assert survivor.gender == valid_attrs.gender
      assert survivor.infected == valid_attrs.infected
      assert survivor.name == valid_attrs.name
    end

    test "create_survivor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Player.create_survivor(@invalid_attrs)
    end

    test "update_survivor/2 with valid data updates the survivor" do
      survivor = insert(:survivor)
      update_attrs = %{age: 43, gender: "some updated gender", infected: false, name: "some updated name"}

      assert {:ok, %Survivor{} = survivor} = Player.update_survivor(survivor, update_attrs)
      assert survivor.age == 43
      assert survivor.gender == "some updated gender"
      assert survivor.infected == false
      assert survivor.name == "some updated name"
    end

    test "update_survivor/2 with invalid data returns error changeset" do
      survivor = insert(:survivor)
      assert {:error, %Ecto.Changeset{}} = Player.update_survivor(survivor, @invalid_attrs)
      assert survivor == Player.get_survivor!(survivor.id)
    end

    test "delete_survivor/1 deletes the survivor" do
      survivor = insert(:survivor)
      assert {:ok, %Survivor{}} = Player.delete_survivor(survivor)
      assert_raise Ecto.NoResultsError, fn -> Player.get_survivor!(survivor.id) end
    end

    test "change_survivor/1 returns a survivor changeset" do
      survivor = insert(:survivor)
      assert %Ecto.Changeset{} = Player.change_survivor(survivor)
    end
  end
end
