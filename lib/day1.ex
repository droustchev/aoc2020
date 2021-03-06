defmodule Day1 do

  def input do
    Aoc.input_lines(__MODULE__)
    |> Stream.map(&String.to_integer/1)
  end

  def part1 do
    for m <- input() do
      n = 2020 - m
      case Enum.member?(input(), n) do
        true -> IO.puts(m * n)
          _ -> :nope
      end
    end
  end

  def part1_rec do
    check(Enum.to_list(input()))
  end

  def check([head | tail]) do
    n = 2020 - head
    case Enum.member?(tail, n) do
      true -> IO.puts(head * n)
        _ -> check(tail)
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
