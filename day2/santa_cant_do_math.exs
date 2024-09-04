defmodule Present_wrapping do
  def calc_wrapping_paper(input) do
    paper_per_present = Enum.map(input, fn present ->
      [l, w, h] = present

      side_1 = l*w
      side_2 = w*h
      side_3 = h*l

      2*side_1 + 2*side_2 + 2*side_3 + Enum.min([side_1, side_2, side_3])
    end)

    Enum.sum(paper_per_present)
  end

  def calc_ribbon(input) do
    ribbon_per_present = Enum.map(input, fn present ->
      [l, w, h] = present

      ribbon_wrap = 2*Enum.min([l+w, w+h, h+l])

      ribbon_bow = l*w*h

      ribbon_bow + ribbon_wrap
    end)

    Enum.sum(ribbon_per_present)
  end
end

input = File.read!("input.txt")
        |> String.trim()
        |> String.split(~r/(x|\n)/)
        |> Enum.map(&String.to_integer/1)
        |> Enum.chunk_every(3)

total_wrapping_paper = Present_wrapping.calc_wrapping_paper(input)
total_ribbon_feet = Present_wrapping.calc_ribbon(input)

IO.puts("Total wrapping paper because santa is stupid and can't do math: #{total_wrapping_paper}")
IO.puts("Santa is retarded and needs: #{total_ribbon_feet} feet of ribbon to wrap presents")
