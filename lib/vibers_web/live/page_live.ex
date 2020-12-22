defmodule VibersWeb.PageLive do
  use VibersWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(
      socket,
      name: "",
      name_check: false,
      surname: "",
      surname_check: false,
      household_no: "",
      household_check: false,
      salary: "",
      comment: "",
      comment_check: false,
      salary_check: false,
      salary_valid: false,
      date_of_birth: "",
      date_of_birth_check: false,
      date_of_birth_valid: false
    )}
  end

  @impl true
  def handle_event("change", %{
    "name" => name,
    "surname" => surname,
    "household_no" => household_no,
    "salary" => salary,
    "comment" => comment,
    "date_of_birth" => date_of_birth
  }, socket) do
    {salary, salary_check, salary_valid} = case Integer.parse(salary) do
      {value, _} -> {value, true, true}
      _ -> {"", true, false}
    end

    {:noreply, assign(
      socket,
      name: name,
      name_check: name,
      surname: surname,
      surname_check: surname,
      household_no: household_no,
      household_check: household_no,
      salary: salary,
      comment: comment,
      comment_check: comment,
      salary_check: salary_check,
      salary_valid: salary_valid,
      date_of_birth: date_of_birth,
      date_of_birth_check: date_of_birth
    )}
  end
end
