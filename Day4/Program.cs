var grid = File.ReadAllLines("input.txt").Select((c) => c.Select((c2) => c2).ToArray()).ToArray();
int count = 0;

bool TestDir(string curString, int x, int y, int xDir, int yDir)
{
  curString += grid[y][x];

  if (curString == "XMAS")
  {
    ++count;
    return true;
  }
  else if (curString.Length == 4)
    return false;

  if (x + xDir < 0 || x + xDir >= grid.Length || y + yDir < 0 || y + yDir >= grid[x].Length)
    return false;

  return TestDir(curString, x + xDir, y + yDir, xDir, yDir);
}

for (int y = 0; y < grid.Length; y++)
{
  for (int x = 0; x < grid[y].Length; x++)
  {
    TestDir("", y, x, 1, 0);
    TestDir("", y, x, -1, 0);
    TestDir("", y, x, 0, -1);
    TestDir("", y, x, 0, 1);

    TestDir("", y, x, 1, -1);
    TestDir("", y, x, -1, -1);

    TestDir("", y, x, 1, 1);
    TestDir("", y, x, -1, 1);
  }
}

int count2 = 0;
for (int y = 0; y < grid.Length; y++)
{
  for (int x = 0; x < grid[y].Length; x++)
  {
    if (grid[y][x] == 'A')
    {
      if (x == 0 || y == 0 || x == grid[y].Length - 1 || y == grid.Length - 1)
        continue;

      var topLeft = grid[y + 1][x - 1];
      var topRight = grid[y + 1][x + 1];
      var botLeft = grid[y - 1][x - 1];
      var botRight = grid[y - 1][x + 1];

      if ((topLeft == 'M' && topRight == 'S' && botLeft == 'M' && botRight == 'S')
          || (topLeft == 'S' && topRight == 'M' && botLeft == 'S' && botRight == 'M')
          || (topLeft == 'M' && topRight == 'M' && botLeft == 'S' && botRight == 'S')
          || (topLeft == 'S' && topRight == 'S' && botLeft == 'M' && botRight == 'M'))
        count2++;
    }
  }
}

Console.WriteLine(count);
Console.WriteLine(count2);
