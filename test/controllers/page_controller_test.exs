defmodule Phitter.PageControllerTest do
  use Phitter.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Phitter"
  end
end
