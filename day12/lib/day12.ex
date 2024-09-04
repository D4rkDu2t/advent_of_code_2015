defmodule Santa_needs_better_employers do
  def santas_messy_stupid_elfs(input) do
    Regex.scan(~r/([0-9]+|-[0-9]+)/, input)
    |> Enum.map(fn [number, _] -> String.to_integer(number) end)
    |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  # Clearly not stolen code from GPT
  def load_and_decode_json(file_path) do
    case File.read(file_path) do
      {:ok, file_content} ->
        case Jason.decode(file_content) do
          {:ok, data} ->
            data
          {:error, reason} ->
            IO.puts("Failed to decode JSON: #{reason}")
        end

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end

  def stupid_red_santa(input, keys) do
    Enum.map(input, fn x ->
      # print type_of(x)
      IO.inspect(is_list(x))
      # stupid_red_santa(x)
  end)
  end
end

file_route = "./files/input.json"

input = File.read!(file_route)
|> String.trim()


# Part 1
Santa_needs_better_employers.santas_messy_stupid_elfs(input)
|> IO.inspect

# Part 2
input_json = Santa_needs_better_employers.load_and_decode_json(file_route)

keys = Map.keys(input_json)

input_no_red = Santa_needs_better_employers.stupid_red_santa(input_json, keys)

# IO.inspect(input_no_red)

# Conver json to string
string_json = Jason.encode!(input_json)

Santa_needs_better_employers.santas_messy_stupid_elfs(string_json)
|> IO.inspect
