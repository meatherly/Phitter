defmodule Phitter.PageController do
  use Phitter.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
