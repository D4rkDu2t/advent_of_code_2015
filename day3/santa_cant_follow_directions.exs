defmodule Following_directions do
  def count_lucky_kids(input) do
    starting_point = {0, 0}
    {visited_houses, _} = Enum.reduce(input, {MapSet.new([starting_point]), starting_point}, fn direction, {acc, current} ->
      new_starting_point = case direction do
        "<" -> {elem(current, 0) - 1, elem(current, 1)}
        ">" -> {elem(current, 0) + 1, elem(current, 1)}
        "^" -> {elem(current, 0), elem(current, 1) + 1}
        "v" -> {elem(current, 0), elem(current, 1) - 1}
        _ -> current
      end
      {MapSet.put(acc, new_starting_point), new_starting_point}
    end)
    visited_houses
  end

  def split_input(input) do
    {santa, mecha_santa} = Enum.with_index(input)
                           |>Enum.split_with(fn {_, index} -> rem(index, 2) == 0 end)

    {
      Enum.map(santa, fn {elem, _} -> elem end),
      Enum.map(mecha_santa, fn {elem, _} -> elem end)
    }
  end

  def present_delivery(santas_input, mecha_santas_input) do
    santas_deliveries = count_lucky_kids(santas_input)
    mecha_santas_deliveries = count_lucky_kids(mecha_santas_input)

    MapSet.union(santas_deliveries, mecha_santas_deliveries)
    |> MapSet.size()
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.graphemes()

total_lucky_children = Following_directions.count_lucky_kids(input)
                       |> MapSet.size()
IO.puts("Stupid bastard Santa only visited: #{total_lucky_children} different houses")

{santas_input, mecha_santas_input} = Following_directions.split_input(input)
total_lucky_children_with_ms = Following_directions.present_delivery(santas_input, mecha_santas_input)
IO.puts("Stupid bastards Santa and Mecha-Santa only visited: #{total_lucky_children_with_ms} different houses")
