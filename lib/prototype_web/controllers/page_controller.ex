defmodule PrototypeWeb.PageController do
  use PrototypeWeb, :controller

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    render(conn, "index.html", user_id: user_id)
  end


  def rick(conn, _params) do
    html(conn, File.read!("priv/static/html/rick.html"))
  end
end