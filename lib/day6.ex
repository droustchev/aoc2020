defmodule Day6 do

  def input do
    Aoc.input_lines(__MODULE__)
  end

  def part1 do
    input()
    |> Stream.chunk_by(fn x -> x != "" end)
    |> Stream.filter(fn x -> hd(x) != "" end)
    |> Stream.map(fn group ->
      Enum.join(group, "")
      |> String.graphemes()
      |> MapSet.new()
    end)
    |> Stream.map(&MapSet.size/1)
    |> Enum.sum()
    |> IO.puts
    # |> Enum.map(&IO.inspect/1)
  end

  def part2 do
    input()
    |> Stream.chunk_by(fn x -> x != "" end)
    |> Stream.filter(fn x -> hd(x) != "" end)
    |> Stream.map(fn group ->
      group
      |> Enum.map(fn person ->
        person
        |> String.graphemes()
        |> MapSet.new()
      end)
    end)
    |> Stream.map(&Enum.reduce(&1,fn x, acc ->
      MapSet.intersection(acc, x)
    end))
    |> Stream.map(&MapSet.size/1)
    |> Enum.sum()
    |> IO.puts
    # |> Enum.map(&IO.inspect/1)
  end

end
