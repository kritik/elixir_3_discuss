defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Repo
  alias DiscussWeb.{Comment,Topic}

  # first time connection
  # * name - name of the channel, like comments:1
  # * params - params sent
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(:comments)

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    IO.puts("+++++++")
    IO.puts(name)
    IO.inspect(content)
    topic = socket.assigns.topic
    user_id   = socket.assigns.user_id
    changeset = topic
      |> Ecto.build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{topic.id}:new",
          %{comment: comment}
        )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

  end
end
