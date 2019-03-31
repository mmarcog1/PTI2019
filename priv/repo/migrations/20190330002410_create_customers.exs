defmodule Prototype.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :description, :text
      add :report, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:customers, [:name])
    create index(:customers, [:user_id])
  end
end
