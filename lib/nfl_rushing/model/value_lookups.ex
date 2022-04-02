defmodule NflRushing.Model.ValueLookups do
  require Ecto.Query

  @spec get_team_id(String.t()) :: {:ok, Integer} | {:error, String.t()}
  def get_team_id(team_abbreviation) do
    q =
      Ecto.Query.from(t in NflRushing.Model.Team,
        where: t.abbreviation == ^team_abbreviation,
        or_where: t.alias_abbreviations == ^team_abbreviation,
        select: t.id
      )

    result = NflRushing.Repo.all(q)

    case result do
      [] -> {:error, "No team found with that abbreviation"}
      [team_id] -> {:ok, team_id}
    end
  end

  @spec get_position_id(String.t()) :: {:ok, Integer} | {:error, String.t()}
  def get_position_id(position_abbreviation) do
    q =
      Ecto.Query.from(p in NflRushing.Model.Position,
        where: p.abbreviation == ^position_abbreviation,
        select: p.id
      )

    result = NflRushing.Repo.all(q)

    case result do
      [] -> {:error, "No position found with that abbreviation"}
      [position_id] -> {:ok, position_id}
    end
  end
end
