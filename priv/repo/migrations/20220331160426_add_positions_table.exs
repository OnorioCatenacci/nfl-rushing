defmodule NflRushing.Repo.Migrations.AddPositionsTable do
  use Ecto.Migration

  def change do
    create table("positions") do
      add :abbreviation, :string, null: false
      add :description, :string, null: false
      add :inserted_at, :utc_datetime, default: fragment("NOW()")
      add :updated_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
