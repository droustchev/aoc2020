defmodule Aoc do
  def input_file(module) do
    %{"day"=> day} = Regex.named_captures(
      ~r/.+(?<day>\d{1})$/,
      inspect(module)
    )

    Path.join([Application.app_dir(:aoc2020, "priv"), "input_#{day}.txt"])
  end

  def input_lines(module) do
    input_file(module)
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
