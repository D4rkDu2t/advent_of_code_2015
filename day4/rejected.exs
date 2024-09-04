alias AdventOfCode.Y2015.IdealStockingStuffer

defmodule AdventOfCode.Y2015.IdealStockingStuffer do
  @secret_key "bgvyzdsv"

  @spec hash_check(pos_integer(), binary()) ::
          {pos_integer(), pos_integer()} | nil
  def hash_check(num, target_prefix) do
    # Print message
    md5_hasher = &:crypto.hash(:md5, &1)

    hash =
      num
      |> Integer.to_string()
      |> String.replace_prefix("", @secret_key)
      |> md5_hasher.()
      |> Base.encode16()

    if hash |> String.starts_with?(target_prefix) do
      nil
    else
      {num, num + 1}
    end
  end

  @spec part1() :: non_neg_integer()
  def part1() do
    checker = &hash_check(&1, "00000")

    1
    |> Stream.unfold(checker)
    |> Enum.to_list()
    |> List.last()
    |> Kernel.+(1)
  end

  @spec part2() :: non_neg_integer()
  def part2() do
    checker = &hash_check(&1, "000000")

    1
    |> Stream.unfold(checker)
    |> Enum.to_list()
    |> List.last()
    |> Kernel.+(1)
  end
end

{time_p1, _} = :timer.tc(fn -> IdealStockingStuffer.part1() end)
IO.puts("Time for part 1 rejected: #{time_p1 / 1_000_000} seconds")

{time_p2, _} = :timer.tc(fn -> IdealStockingStuffer.part2() end)
IO.puts("Time for part 2 rejected: #{time_p2 / 1_000_000} seconds")
