defmodule Count_floors_bsmt do
  def count_floors(floors) do
    {position, _} = Enum.reduce_while(floors, {0, 0}, fn x, {pos, counter} ->
      new_pos = pos + 1
      new_counter = case x do
        "(" -> counter + 1
        ")" -> counter - 1
        _ -> counter
      end

      if new_counter < 0 do
        {:halt, {new_pos, new_counter}}
      else
        {:cont, {new_pos, new_counter}}
      end

    end)
    position
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.graphemes()

bsmt = Count_floors_bsmt.count_floors(input)

IO.puts("The stupid Santa the basement at position: #{bsmt}")
