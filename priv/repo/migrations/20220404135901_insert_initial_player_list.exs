defmodule NflRushing.Repo.Migrations.InsertInitialPlayerList do
  use Ecto.Migration
  alias NflRushing.Controller.Player

  def change do
    Player.insert_players("/app", "rushing.json")
  end
end
