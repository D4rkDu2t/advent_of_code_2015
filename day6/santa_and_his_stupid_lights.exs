defmodule Santas_lights do
  def santa_playing_with_lights(actions) do
    map = %{}

    Enum.reduce(actions, map, fn [action, x1, y1, x2, y2], acc ->
      case action do
        "turn on" ->
          reduce_on_off(acc, x1, y1, x2, y2, true)
        "turn off" ->
          reduce_on_off(acc, x1, y1, x2, y2, false)
        "toggle" ->
          reduce_toggle(acc, x1, y1, x2, y2)
        true ->
          acc
      end
    end)
    |> Enum.count(fn {_, value} -> value == true end)
  end

  def reduce_toggle(map, x1, y1, x2, y2) do
    Enum.reduce(x1..x2, map, fn x, acc ->
      Enum.reduce(y1..y2, acc, fn y, acc_inner ->
        Map.put(acc_inner, {x, y}, !Map.get(map, {x, y}))
      end)
    end)
  end

  def reduce_on_off(map, x1, y1, x2, y2, on_off_toggle) do
    Enum.reduce(x1..x2, map, fn x, acc ->
      Enum.reduce(y1..y2, acc, fn y, acc_inner ->
        Map.put(acc_inner, {x, y}, on_off_toggle)
      end)
    end)
  end

  def santa_playing_with_brightness(actions) do
    map = %{}

    Enum.reduce(actions, map, fn [action, x1, y1, x2, y2], acc ->
      case action do
        "turn on" ->
          change_brightness(acc, x1, y1, x2, y2, 1)
        "turn off" ->
          change_brightness(acc, x1, y1, x2, y2, -1)
        "toggle" ->
          change_brightness(acc, x1, y1, x2, y2, 2)
        true ->
          acc
      end
    end)
    |> Enum.reduce(0, fn {_, value}, acc -> acc + value end)
  end

  def change_brightness(map, x1, y1, x2, y2, brightness) do
    Enum.reduce(x1..x2, map, fn x, acc ->
      Enum.reduce(y1..y2, acc, fn y, acc_inner ->
        current_brightness = Map.get(map, {x, y}, 0)
        new_brightness = max(0, current_brightness + brightness)
        Map.put(acc_inner, {x, y}, new_brightness)
      end)
    end)
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.split(~r/\n/)
        |> Enum.map(fn instruction ->
          Regex.scan(~r/(\d+|turn on|turn off|toggle)/, instruction)
          |> Enum.map(fn [match, _] ->
            action = String.starts_with?(match, "t")
            case action do
              true -> match
              false -> String.to_integer(match)
              end
          end)
      end)

# Part 1
Santas_lights.santa_playing_with_lights(input)
|>IO.inspect()

# Part 2
Santas_lights.santa_playing_with_brightness(input)
|>IO.inspect()
