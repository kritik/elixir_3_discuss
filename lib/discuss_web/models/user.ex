defmodule DiscussWeb.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, DiscussWeb.Topic
    has_many :comments, DiscussWeb.Comment
    
    timestamps()
  end
  
  def changeset(struct, attrs \\ %{}) do # if not set, default value sent
    struct
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end