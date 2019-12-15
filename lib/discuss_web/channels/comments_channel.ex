defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  
  # first time connection
  # * name - name of the channel, like comments:1
  # * params - params sent
  def join(_name, _params, socket) do
    {:ok, %{hey: "there"}, socket}
  end
  
  def handle_in(name, message, socket) do
    IO.puts("+++++++")
    IO.puts(name)
    IO.inspect(message)
    
    {:reply, :ok, socket}
  end
end