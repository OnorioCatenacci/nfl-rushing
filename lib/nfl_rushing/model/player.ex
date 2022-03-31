defmodule NflRushing.Model.Player do
  use Ecto.Schema

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
  end
end
