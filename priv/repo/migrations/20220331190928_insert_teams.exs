defmodule NflRushing.Repo.Migrations.InsertTeams do
  use Ecto.Migration
  alias Ecto.Multi
  require Logger

  def change do
    trans =
      Multi.new()
      |> Multi.insert(:arz, %NflRushing.Model.Team{
        abbreviation: "ARZ",
        city: "Arizona",
        nickname: "Cardinals"
      })
      |> Multi.insert(:atl, %NflRushing.Model.Team{
        abbreviation: "ATL",
        city: "Atlanta",
        nickname: "Falcons"
      })
      |> Multi.insert(:blt, %NflRushing.Model.Team{
        abbreviation: "BLT",
        city: "Baltimore",
        nickname: "Ravens"
      })
      |> Multi.insert(:buf, %NflRushing.Model.Team{
        abbreviation: "BUF",
        city: "Buffalo",
        nickname: "Bills"
      })
      |> Multi.insert(:car, %NflRushing.Model.Team{
        abbreviation: "CAR",
        city: "Carolina",
        nickname: "Panthers"
      })
      |> Multi.insert(:chi, %NflRushing.Model.Team{
        abbreviation: "CHI",
        city: "Chicago",
        nickname: "Bears"
      })
      |> Multi.insert(:cin, %NflRushing.Model.Team{
        abbreviation: "CIN",
        city: "Cincinnati",
        nickname: "Bengals"
      })
      |> Multi.insert(:clv, %NflRushing.Model.Team{
        abbreviation: "CLV",
        city: "Cleveland",
        nickname: "Browns"
      })
      |> Multi.insert(:dal, %NflRushing.Model.Team{
        abbreviation: "DAL",
        city: "Dallas",
        nickname: "Cowboys"
      })
      |> Multi.insert(:den, %NflRushing.Model.Team{
        abbreviation: "DEN",
        city: "Denver",
        nickname: "Broncos"
      })
      |> Multi.insert(:det, %NflRushing.Model.Team{
        abbreviation: "DET",
        city: "Detroit",
        nickname: "Lions"
      })
      |> Multi.insert(:gb, %NflRushing.Model.Team{
        abbreviation: "GB",
        city: "Green Bay",
        nickname: "Packers"
      })
      |> Multi.insert(:hst, %NflRushing.Model.Team{
        abbreviation: "HST",
        city: "Houston",
        nickname: "Texans"
      })
      |> Multi.insert(:ind, %NflRushing.Model.Team{
        abbreviation: "IND",
        city: "Indianapolis",
        nickname: "Colts"
      })
      |> Multi.insert(:jax, %NflRushing.Model.Team{
        abbreviation: "JAX",
        city: "Jacksonville",
        nickname: "Jaguars"
      })
      |> Multi.insert(:kc, %NflRushing.Model.Team{
        abbreviation: "KC",
        city: "Kansas City",
        nickname: "Chiefs"
      })
      |> Multi.insert(:lv, %NflRushing.Model.Team{
        abbreviation: "LV",
        city: "Las Vegas",
        nickname: "Raiders"
      })
      |> Multi.insert(:lac, %NflRushing.Model.Team{
        abbreviation: "LAC",
        city: "Los Angeles",
        nickname: "Chargers"
      })
      |> Multi.insert(:lar, %NflRushing.Model.Team{
        abbreviation: "LAR",
        city: "Los Angeles",
        nickname: "Rams"
      })
      |> Multi.insert(:mia, %NflRushing.Model.Team{
        abbreviation: "MIA",
        city: "Miami",
        nickname: "Dolphins"
      })
      |> Multi.insert(:min, %NflRushing.Model.Team{
        abbreviation: "MIN",
        city: "Minnesota",
        nickname: "Vikings"
      })
      |> Multi.insert(:ne, %NflRushing.Model.Team{
        abbreviation: "NE",
        city: "New England",
        nickname: "Patriots"
      })
      |> Multi.insert(:no, %NflRushing.Model.Team{
        abbreviation: "NO",
        city: "New Orleans",
        nickname: "Saints"
      })
      |> Multi.insert(:nyg, %NflRushing.Model.Team{
        abbreviation: "NYG",
        city: "New York",
        nickname: "Giants"
      })
      |> Multi.insert(:nyj, %NflRushing.Model.Team{
        abbreviation: "NYJ",
        city: "New York",
        nickname: "Jets"
      })
      |> Multi.insert(:phi, %NflRushing.Model.Team{
        abbreviation: "PHI",
        city: "Philadelphia",
        nickname: "Eagles"
      })
      |> Multi.insert(:pit, %NflRushing.Model.Team{
        abbreviation: "PIT",
        city: "Pittsburgh",
        nickname: "Steelers"
      })
      |> Multi.insert(:sf, %NflRushing.Model.Team{
        abbreviation: "SF",
        city: "San Francisco",
        nickname: "49ers"
      })
      |> Multi.insert(:sea, %NflRushing.Model.Team{
        abbreviation: "SEA",
        city: "Seattle",
        nickname: "Seahawks"
      })
      |> Multi.insert(:tb, %NflRushing.Model.Team{
        abbreviation: "TB",
        city: "Tampa Bay",
        nickname: "Buccaneers"
      })
      |> Multi.insert(:ten, %NflRushing.Model.Team{
        abbreviation: "TEN",
        city: "Tennessee",
        nickname: "Titans"
      })
      |> Multi.insert(:was, %NflRushing.Model.Team{
        abbreviation: "WAS",
        city: "Washington",
        nickname: "Football Team"
      })

    result = NflRushing.Repo.transaction(trans)

    case result do
      {:ok, _} -> Logger.info("All teams inserted successfully")
      {:error, _} -> Logger.error("Teams could not be inserted")
    end
  end
end
