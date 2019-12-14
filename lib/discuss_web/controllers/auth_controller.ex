defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  alias DiscussWeb.User
  alias Discuss.Repo
  
  plug Ueberauth
  # pipeline :browser do
  #   plug Ueberauth
  #   ...
  #  end
  
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token, 
      email: auth.info.email,
      provider: conn.assigns.ueberauth_auth.provider|>Atom.to_string,
    }
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
    # require IEx;IEx.pry
  end
  
  def signout(conn, _params) do
    conn
    # |> delete_session(:user_id)
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end
  
  defp signin(conn, cs) do
    case insert_or_update_user(cs) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signin in")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end
  
  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil  -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
   
end