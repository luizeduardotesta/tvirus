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
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = %{age: 15}

      conn = post(conn, Routes.survivor_path(conn, :create), survivor: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update survivor" do
    setup [:create_survivor]

    test "renders survivor when data is valid", %{conn: conn, survivor: survivor} do
      params = %{age: survivor.age}
      conn = put(conn, Routes.survivor_path(conn, :update, survivor), survivor: params)

      assert expected = json_response(conn, 200)["data"]
      assert expected["age"] == params.age
    end

    test "renders errors when data is invalid", %{conn: conn, survivor: survivor} do
      params = %{name: nil}
      conn = put(conn, Routes.survivor_path(conn, :update, survivor), survivor: params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete survivor" do
    setup [:create_survivor]

    test "deletes chosen survivor", %{conn: conn, survivor: survivor} do
      conn = delete(conn, Routes.survivor_path(conn, :delete, survivor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.survivor_path(conn, :show, survivor))
      end
    end
  end

  defp create_survivor(_) do
    survivor = insert(:survivor)
    %{survivor: survivor}
  end
end
