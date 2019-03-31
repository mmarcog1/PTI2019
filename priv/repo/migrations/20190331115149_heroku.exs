defmodule Prototype.Repo.Migrations.Heroku do
  use Ecto.Migration

  def change do
    create table(:test) do
      add :title, :string
      
      timestamps()
    end
  end
end
