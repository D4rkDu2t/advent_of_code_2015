defmodule Santa_the_scammer do
  def hash_string(string) do
    :crypto.hash(:md5, string)
    |> Base.encode16(case: :lower)
  end

  def recursion(input, value, limit, condition) do
    hashed_string = hash_string(input <> Integer.to_string(value))
    if String.slice(hashed_string, 0..limit) == condition do
      value
    else
      recursion(input, value + 1, limit, condition)
    end
  end
end

input = IO.gets("Credit card: ") |> String.trim()

# hashed_cc_5 = Santa_the_scammer.recursion(input, 1, 5-1, String.duplicate("0", 5))
# IO.puts("#{hashed_cc_5}")

# hashed_cc_6 = Santa_the_scammer.recursion(input, 1, 6-1, String.duplicate("0", 6))
# IO.puts("#{hashed_cc_6}")

{time_p1, _} = :timer.tc(fn -> Santa_the_scammer.recursion(input, 1, 5-1, String.duplicate("0", 5)) end)
IO.puts("Time for part 1 handsome: #{time_p1 / 1_000_000} seconds")

{time_p2, _} = :timer.tc(fn -> Santa_the_scammer.recursion(input, 1, 6-1, String.duplicate("0", 6)) end)
IO.puts("Time for part 2 handome: #{time_p2 / 1_000_000} seconds")
