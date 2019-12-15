defmodule DiscussWeb.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "topics" do
    field :title, :string
    belongs_to :user, DiscussWeb.User
    has_many :comments, DiscussWeb.Comment

    timestamps()
  end
  
  @doc false
  def changeset(struct, attrs \\ %{}) do # if not set, default value sent
    struct
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
  
  def owned_by?(conn, topic) do
    conn.assigns.user && conn.assigns.user.id == topic.user_id
  end
  
end