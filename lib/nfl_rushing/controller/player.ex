defmodule NflRushing.Controller.Player do
  alias Ecto.Multi
  alias Jason
  alias NflRushing.Model.Player

  alias NflRushing.Model.ValueLookups

  def insert_player(path, file) do
    Multi.new()
    |> Multi.insert_all(:insert_all, Player, parse_params(path, file))
    |> NflRushing.Repo.transaction()
  end

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

  def parse_params(nil, _file), do: {:error, "You must specify a path"}
  def parse_params(_path, nil), do: {:error, "You must specify a json file to be parsed"}

  def parse_params(path, file) do
    {:ok, params_list} = parse_json(path, file)

    for current_player <- params_list do
      {:ok, team_id} = ValueLookups.get_team_id(current_player["Team"])
      {:ok, position_id} = ValueLookups.get_position_id(current_player["Pos"])

      rushing_yards =
        if is_binary(current_player["Yds"]),
          do: String.to_integer(Enum.join(String.split(current_player["Yds"], "\,"))),
          else: current_player["Yds"]

      NflRushing.Repo.insert(%NflRushing.Model.Player{
        first_name: player_first_name(current_player["Player"]),
        last_name: player_last_name(current_player["Player"]),
        team: team_id,
        position: position_id,
        rushing_attempts_per_game: current_player["Att/G"] / 1.0,
        rushing_attempts: current_player["Att"],
        total_rushing_yards: rushing_yards,
        average_rushing_yards_per_attempt: current_player["Avg"] / 1.0,
        average_rushing_yards_per_game: current_player["Yds/G"] / 1.0,
        total_rushing_touchdowns: current_player["TD"],
        longest_rush: parse_longest_rush(current_player["Lng"]),
        rushing_first_downs: current_player["1st"],
        rushing_first_down_percentage: current_player["1st%"] / 1.0,
        rushes_greater_than_20_yards: current_player["20+"],
        rushes_greater_than_40_yards: current_player["40+"],
        rushing_fumbles: current_player["FUM"]
      })
    end
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

  defp parse_longest_rush(long_rush) when is_binary(long_rush) do
    {longest_rush, _} = Integer.parse(String.trim(long_rush, "T"))
    longest_rush
  end

  defp parse_longest_rush(long_rush) when is_integer(long_rush), do: long_rush
end
