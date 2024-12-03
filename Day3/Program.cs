using System.Text.RegularExpressions;

Console.WriteLine(Regex.Matches(File.ReadAllText("input.txt"), @"mul\((\d+),(\d+)\)").Aggregate(0, (acc, mul) => acc + int.Parse(mul.Groups[1].Value) * int.Parse(mul.Groups[2].Value)));

bool doMul = true;
Console.WriteLine(Regex.Matches(File.ReadAllText("input.txt"), @"mul\((\d+),(\d+)\)|do\(\)|don't\(\)").
    Aggregate(0, (acc, mul) =>
      {
        if (mul.Value == "do()") doMul = true;
        else if (mul.Value == "don't()") doMul = false;
        else if (doMul) acc += int.Parse(mul.Groups[1].Value) * int.Parse(mul.Groups[2].Value);
        return acc;
      }));

