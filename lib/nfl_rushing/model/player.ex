defmodule NflRushing.Model.Player do
  @moduledoc false
  use Ecto.Schema
  require Ecto.Query

  schema "players" do
    field :name, :string
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

  def last_name_list() do
    Ecto.Query.from(
      pl in NflRushing.Model.Player,
      select: pl.last_name
    )
    |> Ecto.Query.distinct(true)
  end

  def list_players_sorted(sort_order) do
    query =
      Ecto.Query.from(
        pl in NflRushing.Model.Player,
        join: t in NflRushing.Model.Team,
        on: t.id == pl.teams_id,
        join: po in NflRushing.Model.Position,
        on: po.id == pl.positions_id,
        order_by: ^filter_player_by(sort_order),
        select: [
          name: pl.name,
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

    query
  end

  def list_players_filtered_and_sorted(sort_order, name) do
    query = list_players_sorted(sort_order)
    filter_by_name = Ecto.Query.from(q in query, select: like(q.name, "%"<>^name<>"%")
    filter_by_name
  end

  defp filter_player_by("total_rushing_yds_asc"), do: [asc: :total_rushing_yards]
  defp filter_player_by("total_rushing_yds_desc"), do: [desc: :total_rushing_yards]
  defp filter_player_by("longest_rush_asc"), do: [asc: :longest_rush]
  defp filter_player_by("longest_rush_desc"), do: [desc: :longest_rush]
  defp filter_player_by("total_rushing_touchdowns_asc"), do: [asc: :total_rushing_touchdowns]
  defp filter_player_by("total_rushing_touchdowns_desc"), do: [desc: :total_rushing_touchdowns]
  defp filter_player_by("unsorted"), do: []
  defp filter_player_by(_), do: []
end
