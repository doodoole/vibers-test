defmodule Vibers.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :surname, :string
      add :household_no, :string
      add :salary, :integer
      add :comment, :string
      add :date_of_birth, :date

      timestamps()
    end

  end
end
