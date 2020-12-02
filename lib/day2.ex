defmodule Day2 do

  def part1 do
    Aoc.input_lines(__MODULE__)
    |> Enum.map(&parse/1)
    |> Enum.map(&valid/1)
    |> Enum.count(&(&1 == :valid))
    |> IO.inspect
    # |> Enum.map(&IO.inspect/1)
  end

  def part2 do
    Aoc.input_lines(__MODULE__)
    |> Enum.map(&parse/1)
    |> Enum.map(&valid2/1)
    |> Enum.count(&(&1 == :valid))
    |> IO.inspect
  end

  defp parse(line) do
    [inst, pw] = line
           |> String.split(": ")

    %{"l" => l, "h" => h, "char" => char} = Regex.named_captures(
      ~r/(?<l>\d+)-(?<h>\d+) (?<char>.)$/,
      inst)

    low = String.to_integer(l)
    high = String.to_integer(h)
    {low, high, char, pw}
  end

  defp valid({l,h,char,pw}) do
    pw_map = pw
             |> String.codepoints
             |> Enum.frequencies

    case Map.get(pw_map, char, 0) do
      freq when l <= freq and freq <= h -> :valid
      _ -> :invalid
    end
  end

  defp valid2({l,h,char,pw}) do
    pw = String.codepoints(pw)

    low_char = Enum.at(pw, l-1)
    high_char = Enum.at(pw, h-1)

    cond do
      low_char == char && high_char != char -> :valid
      low_char != char && high_char == char -> :valid
      true -> :invalid
    end
  end
end
