defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias DiscussWeb.Topic # allows to call just %Topic{}
  
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
    IO.puts("------")
    IO.inspect(params)
    IO.puts("------")
    
    changeset = Topic.changeset(%Topic{}, params)
    IO.inspect(changeset)
    render(conn, "new.html", %{changeset: changeset})
  end
end
  