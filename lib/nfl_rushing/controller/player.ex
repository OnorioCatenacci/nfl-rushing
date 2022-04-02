defmodule NflRushing.Controller.Player do
  @moduledoc false
  alias Ecto.Multi
  alias Jason

  alias NflRushing.Model.ValueLookups

  @spec insert_players(String.t(), String.t()) ::
          {:ok, any()} | {:error, any()}
  def insert_players(path, file) do
    {:ok, player_stats} = parse_player_stats(path, file)

    Multi.new()
    |> Multi.insert_all(:insert_players, NflRushing.Model.Player, player_stats)
    |> NflRushing.Repo.transaction()
  end

  @spec parse_json(String.t(), String.t()) :: {:ok, term()} | {:error, Jason.DecodeError.t()}
  def parse_json(nil, _file), do: {:error, "You must specify a path"}
  def parse_json(_path, nil), do: {:error, "You must specify a json file to be parsed"}

  def parse_json(path, file) do
    # Get file into binary
    with :ok <- File.cd(path),
         {:ok, stream} <-
           File.read(file) do
      Jason.decode(stream)
    else
      {:error, message} -> {:error, "Unable to parse submitted json.  Error is #{message}"}
    end
  end

  @spec parse_player_stats(String.t(), String.t()) :: {:ok, [%{}]} | {:error, String.t()}
  def parse_player_stats(nil, _file), do: {:error, "You must specify a path"}
  def parse_player_stats(_path, nil), do: {:error, "You must specify a json file to be parsed"}

  def parse_player_stats(path, file) do
    {:ok, params_list} = parse_json(path, file)

    player_stats =
      for current_player <- params_list do
        create_new_map_from_player(current_player)
      end

    {:ok, player_stats}
  end

  defp player_first_name(player) do
    # Remove any leading or trailing whitespace
    trimmed_player = String.trim(player)
    [first | _] = String.split(trimmed_player)
    first
  end

  defp player_last_name(player) do
    # Remove any leading or trailing whitespace
    trimmed_player = String.trim(player)
    [_ | last] = String.split(trimmed_player)
    Enum.join(last, " ")
  end

  defp parse_longest_rush(long_rush) when is_integer(long_rush), do: long_rush

  defp parse_longest_rush(long_rush) when is_binary(long_rush) do
    {longest_rush, _} = Integer.parse(String.trim(long_rush, "T"))
    longest_rush
  end

  defp convert_value_to_float(value), do: value / 1.0

  defp clean_integer_with_thousands_separator(value) when is_nil(value), do: 0

  defp clean_integer_with_thousands_separator(value) when is_binary(value),
    do: String.to_integer(Enum.join(String.split(value, "\,")))

  defp clean_integer_with_thousands_separator(value) when not is_nil(value), do: value

  defp create_new_map_from_player(%{} = current_player) do
    {:ok, team_id} = ValueLookups.get_team_id(current_player["Team"])
    {:ok, position_id} = ValueLookups.get_position_id(current_player["Pos"])

    %{
      first_name: player_first_name(current_player["Player"]),
      last_name: player_last_name(current_player["Player"]),
      teams_id: team_id,
      positions_id: position_id,
      rushing_attempts_per_game: convert_value_to_float(current_player["Att/G"]),
      rushing_attempts: current_player["Att"],
      total_rushing_yards: clean_integer_with_thousands_separator(current_player["Yds"]),
      average_rushing_yards_per_attempt: convert_value_to_float(current_player["Avg"]),
      average_rushing_yards_per_game: convert_value_to_float(current_player["Yds/G"]),
      total_rushing_touchdowns: current_player["TD"],
      longest_rush: parse_longest_rush(current_player["Lng"]),
      rushing_first_downs: current_player["1st"],
      rushing_first_down_percentage: convert_value_to_float(current_player["1st%"]),
      rushes_greater_than_20_yards: current_player["20+"],
      rushes_greater_than_40_yards: current_player["40+"],
      rushing_fumbles: current_player["FUM"]
    }
  end
end
