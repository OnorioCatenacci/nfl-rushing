defmodule NflRushing.Repo.Migrations.InsertPositions do
  use Ecto.Migration
  alias Ecto.Multi
  require Logger

  def change do
    trans =
      Multi.new()
      |> Multi.insert(:c, %NflRushing.Model.Position{
        abbreviation: "C",
        description: "Center"
      })
      |> Multi.insert(:rb, %NflRushing.Model.Position{
        abbreviation: "RB",
        description: "Running Back"
      })
      |> Multi.insert(:fb, %NflRushing.Model.Position{
        abbreviation: "FB",
        description: "Fullback"
      })
      |> Multi.insert(:hb, %NflRushing.Model.Position{
        abbreviation: "HB",
        description: "Halfback"
      })
      |> Multi.insert(:og, %NflRushing.Model.Position{
        abbreviation: "OG",
        description: "Offensive Guard"
      })
      |> Multi.insert(:ot, %NflRushing.Model.Position{
        abbreviation: "OT",
        description: "Offensive Tackle"
      })
      |> Multi.insert(:lg, %NflRushing.Model.Position{
        abbreviation: "LG",
        description: "Left Guard"
      })
      |> Multi.insert(:lt, %NflRushing.Model.Position{
        abbreviation: "LT",
        description: "Left Tackle"
      })
      |> Multi.insert(:rg, %NflRushing.Model.Position{
        abbreviation: "RG",
        description: "Right Guard"
      })
      |> Multi.insert(:rt, %NflRushing.Model.Position{
        abbreviation: "RT",
        description: "Right Tackle"
      })
      |> Multi.insert(:te, %NflRushing.Model.Position{
        abbreviation: "TE",
        description: "Tight End"
      })
      |> Multi.insert(:qb, %NflRushing.Model.Position{
        abbreviation: "QB",
        description: "Quarterback"
      })
      |> Multi.insert(:wr, %NflRushing.Model.Position{
        abbreviation: "WR",
        description: "Wide Receiver"
      })
      |> Multi.insert(:cb, %NflRushing.Model.Position{
        abbreviation: "CB",
        description: "Cornerback"
      })
      |> Multi.insert(:de, %NflRushing.Model.Position{
        abbreviation: "DE",
        description: "Defensive End"
      })
      |> Multi.insert(:dt, %NflRushing.Model.Position{
        abbreviation: "DT",
        description: "Defensive Tackle"
      })
      |> Multi.insert(:lb, %NflRushing.Model.Position{
        abbreviation: "LB",
        description: "Linebacker"
      })
      |> Multi.insert(:ilb, %NflRushing.Model.Position{
        abbreviation: "ILB",
        description: "Inside Linebacker"
      })
      |> Multi.insert(:mlb, %NflRushing.Model.Position{
        abbreviation: "MLB",
        description: "Middle Linebacker"
      })
      |> Multi.insert(:nt, %NflRushing.Model.Position{
        abbreviation: "NT",
        description: "Nose Tackle"
      })
      |> Multi.insert(:olb, %NflRushing.Model.Position{
        abbreviation: "OLB",
        description: "Outside Linebacker"
      })
      |> Multi.insert(:s, %NflRushing.Model.Position{
        abbreviation: "S",
        description: "Safety"
      })
      |> Multi.insert(:fs, %NflRushing.Model.Position{
        abbreviation: "FS",
        description: "Free Safety"
      })
      |> Multi.insert(:ss, %NflRushing.Model.Position{
        abbreviation: "SS",
        description: "Strong Safety"
      })
      |> Multi.insert(:k, %NflRushing.Model.Position{
        abbreviation: "K",
        description: "Kicker"
      })
      |> Multi.insert(:kr, %NflRushing.Model.Position{
        abbreviation: "KR",
        description: "Kick Returner"
      })
      |> Multi.insert(:ls, %NflRushing.Model.Position{
        abbreviation: "LS",
        description: "Long Snapper"
      })
      |> Multi.insert(:p, %NflRushing.Model.Position{
        abbreviation: "P",
        description: "Punter"
      })
      |> Multi.insert(:pr, %NflRushing.Model.Position{
        abbreviation: "PR",
        description: "Punt Returner"
      })

    result = NflRushing.Repo.transaction(trans)

    case result do
      {:ok, _} -> Logger.info("All positions inserted successfully")
      {:error, _} -> Logger.error("Positions could not be inserted")
    end
  end
end
