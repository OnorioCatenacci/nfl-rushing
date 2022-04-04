defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller
  alias NflRushing.Model.Player
  require Ecto.Query

  def index(conn, _params) do
    player_list = list_players("no_sort") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def total_rushing_yds(conn, _params) do
    player_list = list_players("total_rushing_yds_asc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def total_rushing_yds_desc(conn, _params) do
    player_list = list_players("total_rushing_yds_desc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def longest_rush(conn, _params) do
    player_list = list_players("longest_rush_asc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def longest_rush_desc(conn, _params) do
    player_list = list_players("longest_rush_desc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def total_rushing_tds(conn, _params) do
    player_list = list_players("total_rushing_touchdowns_asc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def total_rushing_tds_desc(conn, _params) do
    player_list = list_players("total_rushing_touchdowns_desc") |> NflRushing.Repo.all()
    render(conn, "index.html", players: player_list)
  end

  def list_players(sort_order) do
    Ecto.Query.from(
      pl in Player,
      join: t in NflRushing.Model.Team,
      on: t.id == pl.teams_id,
      join: po in NflRushing.Model.Position,
      on: po.id == pl.positions_id,
      order_by: ^filter_player_by(sort_order),
      select: [
        first_name: pl.first_name,
        last_name: pl.last_name,
        team: fragment("concat(?,' ',?)", t.city, t.nickname),
        position: po.description,
        rushing_attempts_per_game: pl.rushing_attempts_per_game,
        rushing_attempts: pl.rushing_attempts,
        total_rushing_yards: pl.total_rushing_yards,
        average_rushing_yards_per_attempt: pl.average_rushing_yards_per_attempt,
        average_rushing_yards_per_game: pl.average_rushing_yards_per_game,
        total_rushing_touchdowns: pl.total_rushing_touchdowns,
        longest_rush: pl.longest_rush,
        rushing_first_downs: pl.rushing_first_downs,
        rushes_greater_than_20_yards: pl.rushes_greater_than_20_yards,
        rushes_greater_than_40_yards: pl.rushes_greater_than_40_yards,
        rushing_fumbles: pl.rushing_fumbles
      ]
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
