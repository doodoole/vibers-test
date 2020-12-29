defmodule Vibers.List.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :comment, :string
    field :date_of_birth, :date
    field :time_of_birth, :time
    field :household_no, :string
    field :name, :string
    field :salary, :integer
    field :surname, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :surname, :household_no, :salary, :comment, :date_of_birth, :time_of_birth])
    |> validate_required([:name, :surname, :household_no, :salary, :comment, :date_of_birth, :time_of_birth])
  end
end
