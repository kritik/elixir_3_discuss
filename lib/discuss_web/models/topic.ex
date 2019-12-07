defmodule DiscussWeb.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Discuss.Topic
  
  schema "topics" do
    field :title, :string

    timestamps()
  end
  
  @doc false
  def changeset(struct, attrs \\ %{}) do # if not set, default value sent
    struct
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
  
end