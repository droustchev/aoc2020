defmodule Day1 do

  def input do
    Aoc.input_lines(__MODULE__)
    |> Stream.map(&String.to_integer/1)
  end

  def part1 do
    for m <- input() do
      n = input()
          |> Enum.filter(&(&1 + m == 2020))

      case n do
        [head|_] ->
          IO.puts("Seems like it is #{m} + #{head}")
          IO.puts("The multiple is #{m*head}")
        [] -> :nope
      end
    end
  end

  def part2 do
    for l <- input() do
      for m <- input() do
        n = input()
            |> Enum.filter(&(&1 + l + m == 2020))

        case n do
          [head|_] ->
            IO.puts("Seems like it is #{l} + #{m} + #{head}")
            IO.puts("The multiple is #{l*m*head}")
          [] -> :nope
        end
      end
    end
  end

end
