defmodule TodoListWeb.PageControllerTest do
  use TodoListWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "TODO's"
  end
end
