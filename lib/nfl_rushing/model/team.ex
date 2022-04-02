defmodule NflRushing.Model.Team do
  use Ecto.Schema

  schema "teams" do
    # Example "JAX"
    field :abbreviation, :string
    # Example: SD (San Diego) for the LA Chargers
    field :alias_abbreviations, :string
    # Example "Jacksonville"
    field :city, :string
    # Example "Jaguars"
    field :nickname, :string

    has_many :players, NflRushing.Model.Player
    timestamps()
  end
end
