defmodule VibersWeb.PageLive do
  use VibersWeb, :live_view
  use Timex
  alias Vibers.List
  alias Vibers.List.Person

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(
      socket,
      changeset: List.change_person(%Person{}),
      date_of_birth: "",
      time_of_birth: "",
      salary_status: nil,
      salary_status_class: ""
    )}
  end

   def to_usa_date(%Date{day: day, month: month, year: year}) do
    "~2..0B/~2..0B/~4..0B"
    |> :io_lib.format([month, day, year])
    |> to_string()
  end
  
  def to_usa_time(%Time{} = time) do
    period = (time.hour < 12 && "am") || "pm"
    hour = time.hour |> rem(12)

    "~2..0B:~2..0B ~2..0s"
    |> :io_lib.format([hour, time.minute, period])
    |> to_string()
  end

  @impl true
  def handle_event("validate", %{"person" => params}, socket) do
    {salary_status, salary_status_class} = case Map.get(params, "salary") do
      nil -> {nil, ""}
      salary -> case Integer.parse(salary) do
        {value, _} ->
          cond do
            value == 1000 -> {"Prosečna", "average"}
            value < 1000 -> {"Manja od prosečne", "lower"}
            value > 1000 -> {"Veća od prosečne", "higher"}
            true -> {nil, ""}
          end
        _ -> {nil, ""}
      end
    end


    changeset =
      %Person{}
      |> List.change_person(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(
      socket,
      changeset: changeset,
      salary_status: salary_status,
      salary_status_class: salary_status_class
    )}
  end
end
