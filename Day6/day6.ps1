
# Get-Content -Path .\input_example.txt | Select-Object 

function Print()
{
  Clear-Host

  for($y = 0; $y -lt $result.Length; $y++)
  {
    # Write-Host $result[$i]
    $a = $result[$y].ToCharArray()
    for($x = 0; $x -lt $a.Length; $x++)
    {
      Write-Host -NoNewline $grid[$y, $x]
    }
    Write-Host ""
  }
}

function Print2($x, $y, $char)
{
  return
  [Console]::SetCursorPosition(  $x ,  $y  )
  [Console]::Write($char)
  [Console]::SetCursorPosition(  $x ,  $y  )
}

$result = get-content .\input.txt 
# Write-Host $result

$grid = New-Object 'char[,]' $result.Length, $result[0].Length
$size_x = $result[0].Length
$size_y = $result.Length


$visited = @{}

for($y = 0; $y -lt $result.Length; $y++)
{
  # Write-Host $result[$i]
  $a = $result[$y].ToCharArray()
  for($x = 0; $x -lt $a.Length; $x++)
  {
    # Write-Host $a[$j]
    $grid[$y, $x] = $a[$x]
  }
}

function Testlol($_x, $_y, [int]$dirX, [int]$dirY, [char]$char, [ref]$curX, [ref]$curY, [ref]$done)
{ 
  if($grid[$_y, $_x] -eq $char)
  {
    $visited["$($_x), $($_y)"] = $true
    $targetX = $_x + $dirX
    $targetY = $_y + $dirY
    if($targetX -lt 0 -or $targetX -ge $size_x -or $targetY -lt 0 -or $targetY -ge $size_y)
    {
      $done.Value = $true
      return 
    }

    if($grid[($_y + $dirY), ($_x + $dirX)] -eq '.') 
    {
      $grid[($_y + $dirY), ($_x + $dirX)] = $char
      $grid[$_y, $_x] = '.'

      $curX.Value = $_x + $dirX
      $curY.Value = $_y + $dirY

      Print2 $_x $_y '.'
      Print2 ($_x + $dirX) ($_y + $dirY) $char
    } else
    {
      switch($char)
      {
        '<'
        { $char = '^' 
        }
        '>'
        { $char = 'v' 
        }
        'v'
        { $char = '<' 
        }
        '^'
        { $char = '>' 
        }
      }
      $grid[$_y, $_x] = $char
      Print2 $_x $_y $char
    }
  }
}

Print


$curX = 0
$curY = 0
$startX = 0
$startY = 0

for([int]$y = 0; $y -lt $size_y; $y++)
{
  for([int]$x = 0; $x -lt $size_x; $x++)
  {
    if($grid[$y, $x] -eq '^')
    {
      $curX = $x
      $curY = $y
      $startX = $x
      $startY = $y
      break
    }
  }
}

$done = $false
Write-Output "Starting at $curX, $curY"
while(!$done)
{
  Testlol $curX $curY -1 0 '<' ([ref]$curX) ([ref]$curY) ([ref]$done) 
  Testlol $curX $curY 1 0 '>' ([ref]$curX) ([ref]$curY) ([ref]$done) 
  Testlol $curX $curY 0 -1 '^' ([ref]$curX) ([ref]$curY) ([ref]$done)
  Testlol $curX $curY 0 1 'v' ([ref]$curX) ([ref]$curY) ([ref]$done) 
}

Write-Output $visited.Count

$grid = New-Object 'char[,]' $result.Length, $result[0].Length

for($y = 0; $y -lt $result.Length; $y++)
{
  # Write-Host $result[$i]
  $a = $result[$y].ToCharArray()
  for($x = 0; $x -lt $a.Length; $x++)
  {
    # Write-Host $a[$j]
    $grid[$y, $x] = $a[$x]
  }
}


$curX = $startX
$curY = $start
$numLoops = 0
Write-Host "Part 2"
for([int]$y = 0; $y -lt $size_y; $y++)
{
  for([int]$x = 0; $x -lt $size_x; $x++)
  {
    $curX = $startX
    $curY = $startY

    if($grid[$y, $x] -eq '.')
    {
      $grid[$y, $x] = '#'
      $count = 0
      $done = $false
      while(!$done)
      {
        Testlol $curX $curY -1 0 '<' ([ref]$curX) ([ref]$curY) ([ref]$done) 
        Testlol $curX $curY 1 0 '>' ([ref]$curX) ([ref]$curY) ([ref]$done) 
        Testlol $curX $curY 0 -1 '^' ([ref]$curX) ([ref]$curY) ([ref]$done)
        Testlol $curX $curY 0 1 'v' ([ref]$curX) ([ref]$curY) ([ref]$done)
        $count++

        if($count -gt 1000)
        {
          #Write-Host("Infinite loop")
          $numLoops++
          break
        }
      }
      $grid[$y, $x] = '.'
      $grid[$startY, $startX] = '^'
      $grid[$curY, $curX] = '.'
    }
  }
}

Write-Host $numLoops
