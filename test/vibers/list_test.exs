defmodule Vibers.ListTest do
  use Vibers.DataCase

  alias Vibers.List

  describe "people" do
    alias Vibers.List.Person

    @valid_attrs %{comment: "some comment", date_of_birth: ~D[2010-04-17], household_no: "some household_no", name: "some name", salary: 42, surname: "some surname"}
    @update_attrs %{comment: "some updated comment", date_of_birth: ~D[2011-05-18], household_no: "some updated household_no", name: "some updated name", salary: 43, surname: "some updated surname"}
    @invalid_attrs %{comment: nil, date_of_birth: nil, household_no: nil, name: nil, salary: nil, surname: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> List.create_person()

      person
    end

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert List.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert List.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = List.create_person(@valid_attrs)
      assert person.comment == "some comment"
      assert person.date_of_birth == ~D[2010-04-17]
      assert person.household_no == "some household_no"
      assert person.name == "some name"
      assert person.salary == 42
      assert person.surname == "some surname"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = List.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = List.update_person(person, @update_attrs)
      assert person.comment == "some updated comment"
      assert person.date_of_birth == ~D[2011-05-18]
      assert person.household_no == "some updated household_no"
      assert person.name == "some updated name"
      assert person.salary == 43
      assert person.surname == "some updated surname"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = List.update_person(person, @invalid_attrs)
      assert person == List.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = List.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> List.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = List.change_person(person)
    end
  end
end
