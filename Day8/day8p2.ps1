
$result = get-content .\input.txt 
# Write-Host $result

$grid = New-Object 'char[,]' $result.Length, $result[0].Length
$antiNodeGrid = New-Object 'char[,]' $result.Length, $result[0].Length
$antiNodeGrid2 = New-Object 'char[,]' $result.Length, $result[0].Length
$size_x = $result[0].Length
$size_y = $result.Length

for($y = 0; $y -lt $result.Length; $y++)
{
  $a = $result[$y].ToCharArray()
  for($x = 0; $x -lt $a.Length; $x++)
  {
    $grid[$y, $x] = $a[$x]
    $antiNodeGrid[$y, $x] = $a[$x]
    $antiNodeGrid2[$y, $x] = $a[$x]
  }
}

for($y = 0; $y -lt $size_y; $y++)
{
  for($x = 0; $x -lt $size_x; $x++)
  {
    for($i = 0; $i -lt $size_y; $i++)
    {
      for($j = 0; $j -lt $size_x; $j++)
      {
        $node1 = $grid[$y, $x]
        $node2 = $grid[$i, $j]

        if($y -eq $i -and $x -eq $j)
        {
          continue
        }

        if($node1 -ceq $node2 -and $node1 -ne "." -and $node2 -ne ".")
        {
          $xDiff = $x - $j
          $yDiff = $y - $i

          $aX = $x + $xDiff
          $aY = $y + $yDiff

          $bX = $j - $xDiff
          $bY = $i - $yDiff

          if($grid[$aY, $aX] -ne $node1)
          {
            if($aY -lt $size_y -and $aX -lt $size_x -and $aY -ge 0 -and $aX -ge 0 -and $antiNodeGrid[$aY, $aX] -ne '#')
            {
              $d1 = [Math]::Abs($aX - $x) + [Math]::Abs($aY - $y)
              $d2 = [Math]::Abs($aX - $j) + [Math]::Abs($aY - $i)

              if($d1 * 2 -eq $d2)
              {
                $antiNodeGrid[$aY, $aX] = '#'
                $count++
              }
            }
          }
          if($grid[$bY, $bX] -ne $node1 -and $bY -ge 0 -and $bX -ge 0)
          {
            if($bY -lt $size_y -and $bX -lt $size_x -and $antiNodeGrid[$bY, $bX] -ne '#')
            {
              $d1 = [Math]::Abs($bX - $j) + [Math]::Abs($bY - $i)
              $d2 = [Math]::Abs($bX - $x) + [Math]::Abs($bY - $y)

              if($d1 * 2 -eq $d2)
              {
                $antiNodeGrid[$bY, $bX] = '#'
                $count++
              }
            }
          }

        }
      }
    }
  }
}

Write-Host $count
$count = 0

for($y = 0; $y -lt $size_y; $y++)
{
  for($x = 0; $x -lt $size_x; $x++)
  {
    for($i = 0; $i -lt $size_y; $i++)
    {
      for($j = 0; $j -lt $size_x; $j++)
      {
        $node1 = $grid[$y, $x]
        $node2 = $grid[$i, $j]

        if($y -eq $i -and $x -eq $j)
        {
          continue
        }

        if($node1 -ceq $node2 -and $node1 -ne "." -and $node2 -ne ".")
        {
          $xDiff = $x - $j
          $yDiff = $y - $i

          for($p = 0; $p -lt $size_y; $p++)
          {
            $newX = [int]::Parse($x) + ($p * $xDiff)
            $newY = [int]::Parse($y) + ($p * $yDiff)

            if($newY -lt $size_y -and $newX -lt $size_x -and $newY -ge 0 -and $newX -ge 0 -and $antiNodeGrid2[$newY, $newX] -ne '#')
            {
              $antiNodeGrid2[$newY, $newX] = '#'
              $count++
            }
          }
        }
      }
    }
  }
}

Write-Host $count
