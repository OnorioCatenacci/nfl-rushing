defmodule Test.NflRushing.Model.PlayerTest do
  use ExUnit.Case, async: true
  alias NflRushing.Model.Player

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NflRushing.Repo)
  end

  test "We should get back one or more records when we query with total rushing yards sort" do
    how_many_players = get_number_of_records_for_sort("total_rushing_yds_asc")

    assert how_many_players >= 1
  end

  test "We should get back one or more records when we query with total rushing yards descending sort" do
    how_many_players = get_number_of_records_for_sort("total_rushing_yds_desc")

    assert how_many_players >= 1
  end

  test "We should get back the same number of records for total rushing yards sorted ascending and descending and both should correspond to the number unsorted" do
    how_many_players_unsorted = get_number_of_records_for_sort("unsorted")
    how_many_players_asc = get_number_of_records_for_sort("total_rushing_yds")
    how_many_players_desc = get_number_of_records_for_sort("total_rushing_yds_desc")

    assert how_many_players_asc == how_many_players_desc and
             how_many_players_asc == how_many_players_unsorted
  end

  test "We should get back one or more records when we query with longest rush sort" do
    how_many_players = get_number_of_records_for_sort("longest_rush_asc")

    assert how_many_players >= 1
  end

  test "We should get back one or more records when we query with longest rush descending sort" do
    how_many_players = get_number_of_records_for_sort("longest_rush_desc")

    assert how_many_players >= 1
  end

  test "We should get back the same number of records for longest rush sorted ascending and descending and both should correspond to the number of unsorted" do
    how_many_players_unsorted = get_number_of_records_for_sort("unsorted")
    how_many_players_asc = get_number_of_records_for_sort("longest_rush_asc")
    how_many_players_desc = get_number_of_records_for_sort("longest_rush_desc")

    assert how_many_players_asc == how_many_players_desc and
             how_many_players_asc == how_many_players_unsorted
  end

  test "We should get back one or more records when we query with total rushing tds sort" do
    how_many_players = get_number_of_records_for_sort("total_rushing_touchdowns_asc")

    assert how_many_players >= 1
  end

  test "We should get back one or more records when we query with total rushing tds descending sort" do
    how_many_players = get_number_of_records_for_sort("total_rushing_touchdowns_desc")

    assert how_many_players >= 1
  end

  test "We should get back the same number of records for total rushing tds sorted ascending and descending and both should correspond to the number of unsorted" do
    how_many_players_unsorted = get_number_of_records_for_sort("unsorted")
    how_many_players_asc = get_number_of_records_for_sort("total_rushing_touchdowns_asc")
    how_many_players_desc = get_number_of_records_for_sort("total_rushing_touchdowns_desc")

    assert how_many_players_asc == how_many_players_desc and
             how_many_players_asc == how_many_players_unsorted
  end

  defp get_number_of_records_for_sort(sort_order) do
    Player.list_players_sorted(sort_order) |> NflRushing.Repo.all() |> length
  end
end
