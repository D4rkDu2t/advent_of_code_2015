defmodule Santas_stupid_count do
  def santa_doesnt_want_to_count(input, repetitions) do
    Enum.reduce(1..repetitions, input, fn _, acc ->
      Regex.scan(~r/(1+|2+|3+|4+|5+|6+|7+|8+|9+|0+)/, acc)
      |> Enum.map(fn [key, _] ->
        lenght = String.length(key)
        key = String.at(key, 0)
        "#{lenght}#{key}"
      end)
      |> Enum.join()
    end)
  end
end

input = "1113222113"

# Part 1
Santas_stupid_count.santa_doesnt_want_to_count(input, 40)
|> String.length()
|> IO.inspect

# Part 2
Santas_stupid_count.santa_doesnt_want_to_count(input, 50)
|> String.length()
|> IO.inspect
