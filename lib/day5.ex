defmodule Day5 do

  def input do
    Aoc.input_lines(__MODULE__)
  end

  def rows do
    Enum.to_list(0..127)
  end

  def split_rows(rows, []), do: rows
  def split_rows(rows, inst) do
    split = Enum.split(rows, trunc(length(rows)/2))
    new_rows = case hd(inst) do
      "F" -> elem(split,0)
      "B" -> elem(split,1)
    end

    split_rows(new_rows, tl(inst))
  end

  def get_row(inst) do
    split_rows(rows(), String.codepoints(inst))
  end

  def columns do
    Enum.to_list(0..7)
  end

  def split_columns(columns, []), do: columns
  def split_columns(columns, inst) do
    split = Enum.split(columns, trunc(length(columns)/2))
    new_columns = case hd(inst) do
      "L" -> elem(split,0)
      "R" -> elem(split,1)
    end
    split_columns(new_columns, tl(inst))
  end

  def get_column(inst) do
    split_columns(columns(), String.codepoints(inst))
  end

  def part1 do
    input()
    |> Stream.map(&String.split_at(&1, -3))
    |> Stream.map(fn {row_inst, column_inst} ->
      row = hd(get_row(row_inst))
      column = hd(get_column(column_inst))
      row * 8 + column
    end)
    |> Enum.max
    |> IO.puts
    # |> Enum.map(&IO.inspect/1)
  end

  def part2 do
    input()
    |> Stream.map(&String.split_at(&1, -3))
    |> Stream.map(fn {row_inst, column_inst} ->
      row = hd(get_row(row_inst))
      column = hd(get_column(column_inst))
      row * 8 + column
    end)
    |> Enum.sort(:desc)
    |> Enum.reduce(928, fn x, acc ->
      cond do
        acc - 1 == x -> x
        true -> acc
      end
    end)
    |> IO.puts
  end

end
