defmodule Day4 do

  @fields MapSet.new(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
  @ecls MapSet.new(["amb","blu","brn","gry","grn","hzl","oth"])

  def input do
    Aoc.input_lines(__MODULE__)
  end

  def input_to_map_stream do
    input()
    |> Stream.chunk_by(fn x -> x != "" end)
    |> Stream.filter(fn x -> hd(x) != "" end)
    |> Stream.map(&Enum.join(&1, " "))
    |> Stream.map(&String.replace(&1," ",":"))
    |> Stream.map(&String.split(&1, ":"))
    |> Stream.map(fn list ->
      Enum.chunk_every(list, 2)
      |> Enum.reduce(%{}, fn [k,v], map -> Map.put(map, k, v) end)
    end)
  end

  def map_to_mapset(map) do
    Map.keys(map) |> MapSet.new()
  end

  def present(m) do
    status =
      m
      |> map_to_mapset()
      |> (&(MapSet.difference(@fields, &1))).()
      |> (&(
        case MapSet.size(&1) do
          0 -> :present
          _ -> :missing
        end)).()
    {m, status}
  end

  def valid_byr(m) do
    case String.to_integer(m["byr"]) do
      x when x >= 1920 and x <= 2002 -> :valid
      _ -> :invalid
    end
  end

  def valid_iyr(m) do
    case String.to_integer(m["iyr"]) do
      x when x >= 2010 and x <= 2020 -> :valid
      _ -> :invalid
    end
  end

  def valid_eyr(m) do
    case String.to_integer(m["eyr"]) do
      x when x >= 2020 and x <= 2030 -> :valid
      _ -> :invalid
    end
  end

  def valid_height(m) do
    case Regex.match?(~r/\d+(cm|in)$/, m["hgt"]) do
      true ->
        {h, unit} = String.split_at(m["hgt"], -2)
        height = String.to_integer(h)
        case unit do
          "cm" ->
            if height >= 150 and height <= 193, do: :valid, else: :invalid
          "in" ->
            if height >= 59 and height <= 76, do: :valid, else: :invalid
        end
      false -> :invalid
    end
  end

  def valid_hcl(m) do
    hcl = m["hcl"]
    case Regex.match?(~r/#[0-9a-f]{6}/, hcl) do
      true -> :valid
      false -> :invalid
    end
  end

  def valid_ecl(m) do
    ecl = m["ecl"]
    case MapSet.member?(@ecls, ecl) do
      true -> :valid
      false -> :invalid
    end
  end

  def valid_pid(m) do
    pid = m["pid"]
    case Regex.match?(~r/^\d{9}$/, pid) do
      true -> :valid
      false -> :invalid
    end
  end

  def validate_all({m, _status}) do
    validity = for fun <- [
      &valid_byr/1,
      &valid_iyr/1,
      &valid_eyr/1,
      &valid_height/1,
      &valid_hcl/1,
      &valid_ecl/1,
      &valid_pid/1
    ], do: fun.(m)

    {m, validity}
  end

  def part1 do
    input_to_map_stream()
    |> Stream.map(&present/1)
    |> Enum.count(fn {_m, status} -> status == :present end)
    |> IO.puts
  end

  def part2 do
    input_to_map_stream()
    |> Stream.map(&present/1)
    |> Stream.filter(fn {_m, status} -> status == :present end)
    |> Stream.map(&validate_all/1)
    |> Enum.count(fn {_m, v} -> !Enum.member?(v, :invalid) end)
    |> IO.puts
  end

end
