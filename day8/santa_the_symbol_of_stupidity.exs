defmodule Santas_stupid_strings do
  def santa_and_his_strings(input) do
    Enum.reduce(input, 0, fn line, acc ->
      memory_string =
        line
        |> String.slice(1..-2//1)
        |>String.replace(~r/\\"/, "\'")
        |>String.replace(~r/"/, "")
        |> String.replace(~r/(\\\\|\\x)/, fn
                "\\x" -> "\\x"
                "\\\\" -> "."
        end)
        |> String.replace(~r/\\x([0-9A-Fa-f]{2})/, fn hex ->
                [_, hex_value] = Regex.run(~r/\\x([0-9A-Fa-f]{2})/, hex)
                int_value = String.to_integer(hex_value, 16)
                <<int_value::utf8>>
        end)
        |> String.length()

      acc + (String.length(line) - memory_string)
    end)
  end


  def santa_and_his_stupid_waste_of_time(input) do
    Enum.reduce(input, 0, fn line, acc ->

      memory_string =
        line
        |> String.replace(~r/\\/, "//")
        |> String.replace(~r/\"/, "/'")
        |> String.length()

      acc + (memory_string + 2 -  String.length(line))
    end)
  end
end

input =
  File.read!("input.txt")
  |> String.trim()
  |> String.split(~r/\n/)

# Part 1
Santas_stupid_strings.santa_and_his_strings(input)
|> IO.inspect

# Part 2
Santas_stupid_strings.santa_and_his_stupid_waste_of_time(input)
|> IO.inspect
