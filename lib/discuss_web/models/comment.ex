defmodule DiscussWeb.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :content, :user_id, :user]}

  schema "comments" do
    field :content, :string
    belongs_to :topic, DiscussWeb.Topic
    belongs_to :user, DiscussWeb.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :topic_id, :user_id])
    |> validate_required([:content, :topic_id, :user_id])
  end
end
