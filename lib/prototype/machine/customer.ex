defmodule Prototype.Machine.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :description, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
