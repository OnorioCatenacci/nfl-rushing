defmodule NflRushing.Model.Player do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

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
end
