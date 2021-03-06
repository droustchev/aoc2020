defmodule Day8 do

  def input do
    Aoc.input_lines(__MODULE__)
  end

  def parse_inst({row, index}) do
    [op | arg] = row |> String.split(" ")
    args = String.split_at(hd(arg), 1)
    {index, op, elem(args,0), String.to_integer(elem(args,1))}
  end

  def compute(instructions, pos, acc, seen) do
    if pos == length(instructions) do
      IO.puts "Found working run, acc: #{acc}"
    end
    {_index, op, dir, offset} = inst = Enum.at(instructions, pos)
    case Enum.member?(seen, inst) do
      true -> IO.puts "Current acc: #{acc}"
      false ->
        case op do
          "nop" ->
            compute(instructions, pos + 1, acc, seen ++ [inst])
          "acc" ->
            case dir do
              "+" -> compute(instructions, pos + 1, acc + offset, seen ++ [inst])
              "-" -> compute(instructions, pos + 1, acc - offset, seen ++ [inst])
            end
          "jmp" ->
            case dir do
              "+" -> compute(instructions, pos + offset, acc, seen ++ [inst])
              "-" -> compute(instructions, pos - offset, acc, seen ++ [inst])
            end
        end
    end
  end

  def compute2(instructions, pos, acc, seen) do
    if pos != length(instructions) do
      {_index, op, dir, offset} = inst = Enum.at(instructions, pos)
      case Enum.member?(seen, inst) do
        true -> {:crash, acc}
        false ->
          {new_pos, new_acc} = case {op, dir} do
            {"nop", _} -> {pos + 1, acc}
            {"acc", "+"} -> {pos + 1, acc + offset}
            {"acc", "-"} -> {pos + 1, acc - offset}
            {"jmp", "+"} -> {pos + offset, acc}
            {"jmp", "-"} -> {pos - offset, acc}
          end
          compute2(instructions, new_pos, new_acc, seen ++ [inst])
      end
    else
      {:term, acc}
    end
  end

  def compute_all(instructions) do
    instructions
    |> Enum.reject(fn {_index, op, _dir, _offset} -> op == "acc" end)
    |> Enum.map(fn {index, _op, _dir, _offset} ->
      new_instructions = case Enum.at(instructions, index) do
        {index, "nop", dir, offset} -> List.replace_at(instructions, index, {index, "jmp", dir, offset})
        {index, "jmp", dir, offset} -> List.replace_at(instructions, index, {index, "nop", dir, offset})
      end
        compute2(new_instructions, 0, 0, [])
    end)
  end

  def part1 do
    instructions = Enum.with_index(input())
                   |> Enum.map(&parse_inst/1)
                   |> Enum.to_list

    compute2(instructions, 0, 0, [])
    |> IO.inspect()
  end

  def part2 do
    instructions = Enum.with_index(input())
                   |> Enum.map(&parse_inst/1)
                   |> Enum.to_list

    compute_all(instructions)
    |> Enum.reject(fn {res, _acc} -> res == :crash end)
    |> hd()
    |> IO.inspect()
  end

end
