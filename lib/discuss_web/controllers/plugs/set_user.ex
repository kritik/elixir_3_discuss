defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller
  
  alias Discuss.Repo
  alias DiscussWeb.User
  
  # runs only once
  def init(default), do: default
  
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)
    
    cond do # switch case, evaluates first is true
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
        # conn.assigns.user => user struct
      true -> # always run, like default action
        assign(conn, :user, nil)
    end
  end
end