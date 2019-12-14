defmodule DiscussWeb.Plugs.RequireAuth do
  alias Phoenix.Controller
  alias DiscussWeb.Router.Helpers
  
  def init(default), do: default
  
  def call(conn, _params) do
    if conn.assigns.user do
      conn
    else
      conn
      |> Controller.put_flash(:error, "You need to sign in")
      |> Controller.redirect(to: Helpers.topic_path(conn, :index))
      |> Plug.Conn.halt() # drop rendering
    end
  end
end