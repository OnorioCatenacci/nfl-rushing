defmodule NflRushing.Repo.Migrations.AddPositionsTable do
  use Ecto.Migration
  alias Ecto.Multi
  require Logger

  def change do
    create table("positions") do
      add :abbreviation, :string, null: false
      add :description, :string, null: false
      timestamps()
    end
  end
end
