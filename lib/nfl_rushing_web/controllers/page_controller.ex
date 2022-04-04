defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller
  alias NflRushing.Model.Player

  def index(conn, _params) do
    render(conn, "index.html", set_data_for_view("no_sort"))
  end

  def total_rushing_yds(conn, _params) do
    render(conn, "index.html", set_data_for_view("total_rushing_yds_asc"))
  end

  def total_rushing_yds_desc(conn, _params) do
    player_list = Player.list_players("total_rushing_yds_desc") |> NflRushing.Repo.all()
    render(conn, "index.html", set_data_for_view("total_rushing_yds_desc"))
  end

  def longest_rush(conn, _params) do
    render(conn, "index.html", set_data_for_view("longest_rush_asc"))
  end

  def longest_rush_desc(conn, _params) do
    render(conn, "index.html", set_data_for_view("longest_rush_desc"))
  end

  def total_rushing_tds(conn, _params) do
    render(conn, "index.html", set_data_for_view("total_rushing_touchdowns_asc"))
  end

  def total_rushing_tds_desc(conn, _params) do
    render(conn, "index.html", set_data_for_view("total_rushing_touchdowns_desc"))
  end

  defp set_data_for_view(player_sort) do
    player_list = Player.list_players(player_sort) |> NflRushing.Repo.all()
    last_name_list = Player.last_name_list() |> NflRushing.Repo.all()
    [players: player_list, last_name_list: last_name_list]
  end
end
