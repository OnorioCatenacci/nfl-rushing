defmodule NflRushing.Repo.Migrations.AddTeamsTable do
  use Ecto.Migration

  def change do
    create table("teams") do
      add :abbreviation, :string, null: false
      add :city, :string, null: false
      add :nickname, :string, null: false
      timestamps()
    end
  end
end
