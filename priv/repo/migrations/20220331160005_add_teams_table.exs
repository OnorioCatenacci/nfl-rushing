defmodule NflRushing.Repo.Migrations.AddTeamsTable do
  use Ecto.Migration

  def change do
    create table("teams") do
      add :abbreviation, :string, null: false
      add :city, :string, null: false
      add :nickname, :string, null: false
      add :inserted_at, :utc_datetime, default: fragment("NOW()")
      add :updated_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
