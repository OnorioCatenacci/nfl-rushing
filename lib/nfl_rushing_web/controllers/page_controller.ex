defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller
  alias NflRushing.Model.Player
  require Ecto.Query

  def index(conn, _params) do
    player_list = list_players() |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def list_players(params \\ %{}) do
    Ecto.Query.from(
      pl in Player,
      join: t in NflRushing.Model.Team,
      on: t.id == pl.teams_id,
      order_by: ^filter_player_by(params["order_by"])
      # select: [
      #   # %{
      #   pl.first_name,
      #   pl.last_name,
      #   pl.rushing_attempts_per_game,
      #   pl.rushing_attempts,
      #   pl.total_rushing_yards,
      #   pl.average_rushing_yards_per_attempt,
      #   pl.average_rushing_yards_per_game,
      #   pl.total_rushing_touchdowns,
      #   pl.longest_rush,
      #   pl.rushing_first_downs,
      #   pl.rushing_first_down_percentage,
      #   pl.rushes_greater_than_20_yards,
      #   pl.rushes_greater_than_40_yards,
      #   pl.rushing_fumbles,
      #   team_name: fragment("concat(?, ' ', ?)", t.city, t.nickname)
      #   # }
      # ]
    )
  end

  defp filter_player_by("total_rushing_yds_asc"), do: [asc: :total_rushing_yards]
  defp filter_player_by("total_rushing_yds_desc"), do: [desc: :total_rushing_yards]
  defp filter_player_by("longest_rush_asc"), do: [asc: :longest_rush]
  defp filter_player_by("longest_rush_desc"), do: [desc: :longest_rush]
  defp filter_player_by("total_rushing_touchdowns_asc"), do: [asc: :total_rushing_touchdowns]
  defp filter_player_by("total_rushing_touchdowns_desc"), do: [desc: :total_rushing_touchdowns]
  defp filter_player_by(_), do: []
end
