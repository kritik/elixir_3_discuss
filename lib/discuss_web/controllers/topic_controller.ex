defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  
  def new(conn, _params) do
    # IO.puts("------")
    # IO.inspect(conn)
    # IO.puts("------")
    # IO.inspect(params)
    # IO.puts("------")
    render(conn, "new.html")
  end
end
  