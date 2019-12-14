defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias DiscussWeb.Topic # allows to call just %Topic{}
  alias Discuss.Repo
  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit,:update, :delete]
  plug :check_topic_owner when action in [:edit, :update, :delete]
  
  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end
  
  def new(conn, params) do
    # IO.puts("------")
    # IO.inspect(conn)
    # IO.puts("------")
    # IO.inspect(params)
    # IO.puts("------")
    changeset = Topic.changeset(%Topic{}, params)
    render(conn, "new.html", changeset: changeset) # like %{changeset: changeset}
  end
  
  def create(conn, %{"topic" => params}) do
    # changeset = Topic.changeset(%Topic{}, params)
    changeset = conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(params)
    case Repo.insert(changeset) do
      {:ok, _post} -> 
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset}-> 
        render(conn, "new.html", %{changeset: changeset})
    end
  end
  
  def edit(conn, %{"id"=>id}) do
    topic = Repo.get(Topic, id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end
  
  def update(conn,  %{"id"=>id, "topic"=> params}) do
    changeset = Topic.changeset(Repo.get(Topic, id), params)
    case Repo.update(changeset) do
      {:ok, _post} -> 
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset}-> 
        render(conn, "edit.html", %{changeset: changeset, topic: %Topic{id: id}})
    end
  end
  
  def delete(conn, %{"id"=>id}) do
    Repo.delete!(%Topic{id: id|>String.to_integer})
    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
  
  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    topic = Repo.get(Topic, topic_id)
    if topic && Topic.owned_by?(conn, topic) do
      conn
    else
      conn 
        |> put_flash(:error, "You cannot edit that")
        |> redirect(to: Routes.topic_path(conn, :index))
        |> halt()
      end
  end
end
  