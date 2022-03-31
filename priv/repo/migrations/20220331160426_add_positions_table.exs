defmodule NflRushing.Repo.Migrations.AddPositionsTable do
  use Ecto.Migration

  def change do
    create table("positions") do
      add :abbreviation, :string, null: false
      add :description, :string, null: false
      timestamps()
    end
  end
end
