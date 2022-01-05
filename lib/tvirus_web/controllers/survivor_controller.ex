defmodule TvirusWeb.SurvivorController do
  use TvirusWeb, :controller

  alias Tvirus.Player
  alias Tvirus.Player.Survivor

  action_fallback TvirusWeb.FallbackController

  def index(conn, _params) do
    survivors = Player.list_survivors()
    render(conn, "index.json", survivors: survivors)
  end

  def create(conn, %{"survivor" => survivor_params}) do
    with {:ok, %Survivor{} = survivor} <- Player.create_survivor(survivor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.survivor_path(conn, :show, survivor))
      |> render("show.json", survivor: survivor)
    end
  end

  def show(conn, %{"id" => id}) do
    survivor = Player.get_survivor!(id)
    render(conn, "show.json", survivor: survivor)
  end

  def update(conn, %{ "id" => id, "last_location" => last_location}) do
    with survivor <- Player.get_survivor(id),
         {:ok, %Survivor{} = survivor} <- Player.update_survivor(survivor, last_location) do
      render(conn, "show.json", survivor: survivor)
    end
  end
end
