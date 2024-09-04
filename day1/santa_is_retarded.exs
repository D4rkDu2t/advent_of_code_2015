defmodule Count_floors do
  def count_characters(string, character) do
    string
    |> Enum.filter(&(&1 == character))
    |> Enum.count()
  end

  def calculate_floor(input) do
    floors_up = count_characters(input, "(")
    floors_down = count_characters(input, ")")
    floors_up - floors_down
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.graphemes()

count = Count_floors.calculate_floor(input)

IO.puts("The floor is: #{count}")
