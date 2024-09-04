defmodule Santa_judges_by_names do
  def judge_name_part1(input) do
    count_good_kids = Enum.reduce(input, 0, fn name, acc ->
      cond do
        not String.match?(name, ~r/([a-zA-Z])\1/) ->
          acc

        Regex.scan(~r/[aeiouAEIOU]/, name)
        |> Enum.count() < 3 ->
          acc

        String.match?(name, ~r/(ab|cd|pq|xy)/) ->
          acc

        true ->
          acc + 1
      end
    end)
    count_good_kids
  end

  def judge_name_part2(input) do
    count_good_kids = Enum.reduce(input, 0, fn name, acc ->
      cond do
        Regex.scan(~r/(.).\1/, name) |> Enum.count() < 1 ->
          acc

        Regex.scan(~r/(\w{2,}).*\1/, name) |> Enum.count() < 1 ->
          acc

        true ->
          acc + 1
      end
    end)
    count_good_kids
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.split(~r/\n/)

good_kids_1 = Santa_judges_by_names.judge_name_part1(input)
IO.puts("#{good_kids_1}")

good_kids_2 = Santa_judges_by_names.judge_name_part2(input)
IO.puts("#{good_kids_2}")
