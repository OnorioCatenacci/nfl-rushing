defmodule NflRushing.Repo.Migrations.AddPlayersTable do
  use Ecto.Migration

  def change do
    create table("players") do
      add :first_name, :string
      add :last_name, :string
      add :team_id, references("teams"), null: false
      add :position_id, references("positions"), null: false
      add :rushing_attempts_per_game, :float
      add :rushing_attempts, :integer
      add :total_rushing_yards, :integer
      add :average_rushing_yards_per_attempt, :float
      add :average_rushing_yards_per_game, :float
      add :total_rushing_touchdowns, :integer
      add :longest_rush, :integer
      add :rushing_first_downs, :integer
      add :rushing_first_down_percentage, :float
      add :rushes_greater_than_20_yards, :integer
      add :rushes_greater_than_40_yards, :integer
      add :rushing_fumbles, :integer

      timestamps()
    end
  end
end
