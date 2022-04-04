defmodule NflRushing.Model.Player do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  require Ecto.Query

  schema "players" do
    field :first_name, :string
    field :last_name, :string
    field :rushing_attempts_per_game, :float
    field :rushing_attempts, :integer
    field :total_rushing_yards, :integer
    field :average_rushing_yards_per_attempt, :float
    field :average_rushing_yards_per_game, :float
    field :total_rushing_touchdowns, :integer
    field :longest_rush, :integer
    field :rushing_first_downs, :integer
    field :rushing_first_down_percentage, :float
    field :rushes_greater_than_20_yards, :integer
    field :rushes_greater_than_40_yards, :integer
    field :rushing_fumbles, :integer

    belongs_to :teams, NflRushing.Model.Team
    belongs_to :positions, NflRushing.Model.Position
  end

  def changeset(player, params) do
    player
    |> cast(params, [
      :first_name,
      :last_name,
      :teams_id,
      :positions_id,
      :rushing_attempts_per_game,
      :rushing_attempts,
      :total_rushing_yards,
      :average_rushing_yards_per_attempt,
      :average_rushing_yards_per_game,
      :total_rushing_touchdowns,
      :longest_rush,
      :rushing_first_downs,
      :rushing_first_down_percentage,
      :rushes_greater_than_20_yards,
      :rushes_greater_than_40_yards,
      :rushing_fumbles
    ])
    |> validate_number(:rushing_attempts_per_game, greater_than_or_equal_to: 0)
    |> validate_number(:rushing_attempts, greater_than_or_equal_to: 0)
    |> validate_number(:total_rushing_touchdowns, greater_than_or_equal_to: 0)
    |> validate_number(:rushing_first_downs, greater_than_or_equal_to: 0)
    |> validate_number(:rushing_first_down_percentage, greater_than_or_equal_to: 0)
    |> validate_number(:rushes_greater_than_20_yards, greater_than_or_equal_to: 0)
    |> validate_number(:rushes_greater_than_40_yards, greater_than_or_equal_to: 0)
    |> validate_number(:rushing_fumbles, greater_than_or_equal_to: 0)
  end

  def last_name_list() do
    Ecto.Query.from(
      pl in NflRushing.Model.Player,
      select: pl.last_name
    )
    |> Ecto.Query.distinct(true)
  end

  def list_players(sort_order) do
    Ecto.Query.from(
      pl in NflRushing.Model.Player,
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
