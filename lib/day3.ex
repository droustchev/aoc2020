defmodule Day3 do

  def input do
    Aoc.input_lines(__MODULE__)
  end


  def part1 do
    traverse(3, 1)
  end

  def part2 do
    Enum.reduce([{1,1}, {3,1}, {5,1}, {7,1}, {1,2}], 1, fn {y,x}, acc ->
      acc * traverse(y,x)
    end)
    |> IO.puts
  end

  def traverse(y, x) do
    trees = input()
            |> Stream.with_index()
            |> Enum.map(fn {str, index} ->
              # IO.puts index
              # IO.puts str
              if index > 0 and rem(index,x) == 0 do
                offset = if x > 1, do: trunc(index/2), else: index * y
                # IO.puts List.replace_at(String.codepoints(str), offset, "X")
                case Enum.at(Stream.cycle(String.codepoints(str)), offset, :nil) do
                  "#" -> :x
                  "." -> :o
                  _ -> :woopsie
                end
              end
            end)
            |> Enum.count(fn x -> x === :x end)

    IO.puts("Right #{y}, down #{1}: #{trees}")
    # |> Enum.map(&IO.inspect/1)
    trees
  end


  # def traverse do
  #   tl(extend())

  # end

  # def extend do
  #   repeats = trunc(repeats())
  #   input()
  #   |> Enum.map(&String.duplicate(&1, repeats))
  # end

  # def repeats do
  #   width = String.length(hd(Enum.to_list(input())))
  #   rows = length(Enum.to_list(input()))
  #   Float.ceil(rows/width)
  # end

end
