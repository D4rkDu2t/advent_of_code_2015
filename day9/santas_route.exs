defmodule Santas_journey do
  def santa_brute_without_force(distances, min_route) do
    locations_count = length(distances)

    base_case = Enum.map(0..locations_count-1, fn index ->
      index
    end)

    routes = permutations(base_case)

    Enum.reduce(routes, {nil, 0}, fn route, {optimal_route, optimal_distance} ->

      distance = Enum.reduce(0..length(route)-2, 0, fn index, acc ->
        row = Enum.at(route, index)
        col = Enum.at(route, index+1)

        value = Enum.at(distances, row)
        |> Enum.at(col)

        acc + value
      end)

      case optimal_route do
        nil -> {route, distance}
        _ ->
          case min_route do
            true -> update_distance(distance, optimal_distance, route, optimal_route, true)
            false -> update_distance(distance, optimal_distance, route, optimal_route, false)
          end
      end
    end)
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for(item <- list, rest <- permutations(list -- [item]), do: [item | rest])
  end

  def update_distance(new_distance, current_optimal_dis, new_route, current_optimal_route, min_route) do
    update = case min_route do
      true -> new_distance < current_optimal_dis
      false -> new_distance > current_optimal_dis
    end

    if update do
      {new_route, new_distance}
    else
      {current_optimal_route, current_optimal_dis}
    end
  end
end

# Format base input into a list of [loc_1, loc_2, distance]
input = File.read!("input.txt")
|> String.trim()
|> String.split(~r/\n/)
|>Enum.map(fn line ->
  [loc_1, _, loc_2, _, distance] = String.split(line, " ")
  [loc_1, loc_2, String.to_integer(distance)]
end)

# Get all unique locations names
locations = Enum.map(input, fn [loc_1, loc_2, _] -> [loc_1, loc_2] end)
|> List.flatten()
|> Enum.uniq()
|> Enum.with_index()

# Create a matrix of distances
distances = Enum.map(0..length(locations)-1, fn row ->
  Enum.map(0..length(locations)-1, fn col ->
    case row == col do
      true -> 0
      false ->
        {loc_1, _} = Enum.find(locations, fn {_, index} -> index == row end)
        {loc_2, _} = Enum.find(locations, fn {_, index} -> index == col end)

        distance = Enum.find(input, fn [a, b, _] ->
          (a == loc_1 and b == loc_2) or (a == loc_2 and b == loc_1)
        end)

        case distance do
          nil -> 0
          _ -> Enum.at(distance, 2)
        end
    end
  end)
end)

# Part 1
Santas_journey.santa_brute_without_force(distances, true)
|> IO.inspect

# Part 1
Santas_journey.santa_brute_without_force(distances, false)
|> IO.inspect
