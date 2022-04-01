defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def import(conn, _params) do
  end
end
