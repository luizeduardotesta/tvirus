defmodule TvirusWeb.SurvivorControllerTest do
  use TvirusWeb.ConnCase

  import Tvirus.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all survivors", %{conn: conn} do
      conn = get(conn, Routes.survivor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create survivor" do
    test "renders survivor when data is valid", %{conn: conn} do
      params = params_for(:survivor)

      conn = post(conn, Routes.survivor_path(conn, :create), survivor: params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["name"] == params.name
      assert subject["age"] == params.age
      assert subject["gender"] == params.gender
      assert subject["infected"] == params.infected
      assert subject["id"] != nil

      assert last_location = subject["last_location"]
      assert last_location["latitude"] == params.latitude
      assert last_location["longitude"] == params.longitude
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = %{age: 15}

      conn = post(conn, Routes.survivor_path(conn, :create), survivor: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update last_location" do
    setup [:create_survivor]

    test "update last_location when valid data", %{conn: conn, survivor: survivor} do
      params = %{latitude: "22.55", longitude: "67.11"}

      conn = put(conn, Routes.survivor_path(conn, :update, survivor.id), last_location: params)

      assert subject = json_response(conn, 200)["data"]
      assert last_location = subject["last_location"]
      assert last_location["latitude"] == params.latitude
      assert last_location["longitude"] == params.longitude
    end
  end

  describe "update infected" do
    setup [:create_survivor]

    test "update infected when 5 susrvivors flaged", %{conn: conn, survivor: survivor} do
      params = %{flager_id: insert(:survivor).id}
      flag = MapSet.new([survivor.id, insert(:survivor).id, insert(:survivor).id, insert(:survivor).id])
      flaged = insert(:survivor, %{flag: flag, infected: false})

      conn = put(conn, Routes.survivor_path(conn, :update, flaged.id), params)

      assert subject = json_response(conn, 200)["data"]
      assert subject["infected"] == true
      assert subject["id"] == flaged.id
    end

    test "fail to update infected when alredy flaged", %{conn: conn, survivor: survivor} do
      params = %{flager_id: survivor.id}
      flag = MapSet.new([survivor.id])
      flaged = insert(:survivor, %{flag: flag, infected: false})

      conn = put(conn, Routes.survivor_path(conn, :update, flaged.id), params)

      assert "this guy is alredy flaged by you" = json_response(conn, 400)["error"]
    end
  end

  defp create_survivor(_) do
    survivor = insert(:survivor)
    %{survivor: survivor}
  end
end
