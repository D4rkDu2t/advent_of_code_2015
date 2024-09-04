defmodule Santas_password do
  def santas_weird_password(input) do
    # a in ascii
    min_value = 97
    # z in ascii
    max_value = 122

    new_password = increment_password(input, min_value, max_value)

    if check_forbidden_chars(new_password) and check_pairs(new_password) and check_consecutives(new_password) do
      new_password
    else
      santas_weird_password(new_password)
    end
  end

  def increment_password(password, min_value, max_value) do
    {reversed_password, _} =
    password
    |> Enum.reverse()
    |> Enum.reduce({[], true}, fn value, {acc, carry_over} ->
      if carry_over do
        if value == max_value do
          {acc ++ [min_value], true}
        else
          {acc ++ [value+1], false}
        end
      else
        {acc ++ [value], false}
      end
    end)

    Enum.reverse(reversed_password)
  end

  def check_forbidden_chars(password) do
    forbidden_chars = [105, 108, 111]
    !Enum.any?(password, fn x -> Enum.member?(forbidden_chars, x) end)
  end

  def check_pairs(password) do
    {total_pairs, _} = Enum.reduce(1..length(password)-2, {0, 0}, fn _, {pairs, index} ->
      if Enum.at(password, index) == Enum.at(password, index+1) do
        {pairs+1, index+2}
      else
        {pairs, index+1}
      end
    end)

    total_pairs > 1
  end

  def check_consecutives(password) do
    total_consecutives = Enum.reduce(0..length(password)-3, 0, fn x, consecutives ->
      value = Enum.at(password, x)

      if value+1 == Enum.at(password, x+1) and value+2 == Enum.at(password, x+2) do
        consecutives+1
      else
        consecutives
      end
    end)
    total_consecutives >= 1
  end
end

input = "hepxcrrq"
|> String.graphemes()
|> Enum.map(fn x ->
  x
  |> String.to_charlist()
  |> hd()
end)


new_password = Santas_password.santas_weird_password(input)
|> IO.inspect()

Santas_password.santas_weird_password(new_password)
|> IO.inspect()
