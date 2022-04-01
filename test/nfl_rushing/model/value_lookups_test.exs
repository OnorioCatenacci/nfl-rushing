defmodule Test.NflRushing.Model.ValueLookupsTest do
  use ExUnit.Case, async: true
  alias NflRushing.Model.ValueLookups

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NflRushing.Repo)
  end

  test "Bad team abbreviation returns error" do
    bad_team_abbreviation = "ERR"
    assert {:error, _} = ValueLookups.get_team_id(bad_team_abbreviation)
  end

  test "Good team abbreviation returns number" do
    good_team_abbreviation = "NYG"
    {:ok, team_id} = ValueLookups.get_team_id(good_team_abbreviation)
    assert is_integer(team_id)
  end

  test "Bad position abbreviation returns error" do
    bad_position_abbreviation = "ERR"
    assert {:error, _} = ValueLookups.get_position_id(bad_position_abbreviation)
  end

  test "Good position abbreviation returns number" do
    good_position_abbreviation = "QB"
    {:ok, position_id} = ValueLookups.get_position_id(good_position_abbreviation)
    assert is_integer(position_id)
  end
end
