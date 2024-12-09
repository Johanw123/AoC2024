Console.WriteLine(File.ReadAllLines("input.txt").Aggregate(0, (safe, line) =>
{
  if (line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) => { if (acc == 0 || num > acc && Math.Abs(acc - num) <= 3) acc = num; else acc = int.MaxValue; return acc; }) != int.MaxValue
      || line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) => { if (acc == 0 || num < acc && Math.Abs(acc - num) <= 3) acc = num; else acc = int.MinValue; return acc; }) != int.MinValue)
    safe++;
  return safe;
}));

Console.WriteLine(File.ReadAllLines("input.txt").Aggregate(0, (safe, line) =>
{
  bool test = true;
  if (line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) => { if (acc == 0 || num > acc && Math.Abs(acc - num) <= 3) acc = num; else acc = int.MaxValue; return acc; }) != int.MaxValue
      || line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) => { if (acc == 0 || num < acc && Math.Abs(acc - num) <= 3) acc = num; else acc = int.MinValue; return acc; }) != int.MinValue)
    safe++;
  return safe;
}));

// bool test = true;
// Console.WriteLine(File.ReadAllLines("input.txt").Aggregate(0, (safe, line) =>
// {
//   Console.WriteLine("Line: " + line);
//   test = true;
//   if (line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) =>
//           { if (acc == 0 || (acc != int.MinValue && num < acc && Math.Abs(acc - num) <= 3)) acc = num; else { if (test) { test = false; } else { acc = int.MinValue; } }; Console.WriteLine(acc); return acc; }) != int.MinValue)
//   {
//     safe++;
//
//     Console.WriteLine("Its Safe!: " + safe);
//   }
//   return safe;
// }));

// bool test = true;
// Console.WriteLine(File.ReadAllLines("input.txt").Aggregate(0, (safe, line) =>
// {
//
//   test = true;
//   bool s = false;
//
//   if (line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) =>
//         { if (acc == 0 || (acc != int.MaxValue && num > acc && Math.Abs(acc - num) <= 3)) acc = num; else { if (test) { test = false; } else { acc = int.MaxValue; } }; return acc; }) != int.MaxValue)
//
//   {
//     safe++;
//     s = true;
//   }
//   else
//   {
//     if (line.Split(" ").Skip(1).Select(int.Parse).ToList().Aggregate(0, (acc, num) =>
//         { if (acc == 0 || (acc != int.MaxValue && num > acc && Math.Abs(acc - num) <= 3)) acc = num; else { if (test) { test = false; } else { acc = int.MaxValue; } }; return acc; }) != int.MaxValue)
//       safe++;
//   }
//
//   test = true;
//   if (line.Split(" ").Select(int.Parse).ToList().Aggregate(0, (acc, num) =>
//           { if (acc == 0 || (acc != int.MinValue && num < acc && Math.Abs(acc - num) <= 3)) acc = num; else { if (test) { test = false; } else { acc = int.MinValue; } }; return acc; }) != int.MinValue)
//   {
//     safe++;
//     s = true;
//   }
//   else
//   {
//     if (line.Split(" ").Skip(1).Select(int.Parse).ToList().Aggregate(0, (acc, num) =>
//              { if (acc == 0 || (acc != int.MinValue && num < acc && Math.Abs(acc - num) <= 3)) acc = num; else { if (test) { test = false; } else { acc = int.MinValue; } }; return acc; }) != int.MinValue)
//       safe++;
//   }
//
//
//   if (!s)
//   {
//
//     Console.WriteLine("Line: " + line);
//     Console.WriteLine("Not Safe!");
//   }
//   return safe;
// }));



