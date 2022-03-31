defmodule NflRushing.Model.Position do
  use Ecto.Schema

  schema "positions" do
    # Example: WR
    field :abbreviation, :string
    # Example: Wide Reciever
    field :description, :string

    has_many :players, NflRushing.Model.Player
    timestamps()
  end
end
