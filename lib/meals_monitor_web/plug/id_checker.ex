defmodule MealsMonitorWeb.Plug.IdChecker do
  import Plug.Conn

  alias Plug.Conn

  def init(opts), do: opts

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case Integer.parse(id) do
      {_id, ""} -> conn
      _ -> render_error(conn)
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{success: false, message: "Invalid id format!"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
