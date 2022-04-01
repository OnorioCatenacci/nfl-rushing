defmodule Test.NflRushing.Controller.PlayerTest do
  use ExUnit.Case, async: true
  alias NflRushing.Controller.Player

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NflRushing.Repo)
  end

  test "Nil path should result in error message" do
    assert {:error, "You must specify a path"} = Player.parse_json(nil, "rushing.json")
  end

  test "Nil file should result in an error message" do
    assert {:error, "You must specify a json file to be parsed"} = Player.parse_json("/app", nil)
  end

  test "Non-existent path should result in an error message indicating no such file exists" do
    assert {:error, "Unable to parse submitted json.  Error is enoent"} =
             Player.parse_json("NoSuchPathExists", "rushing.json")
  end

  test "Non-existent file should result in an error message indicating no such file exists" do
    assert {:error, "Unable to parse submitted json.  Error is enoent"} =
             Player.parse_json("/app", "nofile.json")
  end
end
