function Test([uint64]$sum, $operator, $values, $curIndex, $target, [ref]$found)
{
  if($found.Value -eq $true)
  {
    return
  }

  if($sum -gt $target)
  {
    return
  }

  if($curIndex -eq $values.Count)
  {
    if($sum -eq $target)
    {
      $found.Value = $true
    }
    return
  }


  [uint64]$curValue = [uint64]::Parse($values[$curIndex])
  $curValueString = $values[$curIndex]
  $sumString = $sum.ToString()
  $curIndex++

  if($operator -eq '+')
  {
    Test ($sum + $curValue) '+' $values $curIndex $target $found
    Test ($sum + $curValue) '*' $values $curIndex $target $found
    Test ($sum + $curValue) 'c' $values $curIndex $target $found
  } elseif($operator -eq '*')
  {

    Test ($sum * $curValue) '+' $values $curIndex $target $found
    Test ($sum * $curValue) '*' $values $curIndex $target $found
    Test ($sum * $curValue) 'c' $values $curIndex $target $found
  } else
  {
    $newSum = $sumString + $curValueString
    Test ([uint64]::Parse($newSum)) '+' $values $curIndex $target $found
    Test ([uint64]::Parse($newSum)) '*' $values $curIndex $target $found
    Test ([uint64]::Parse($newSum)) 'c' $values $curIndex $target $found
  }
}

$result = get-content .\input.txt

$totalSum = 0
foreach ($line in $result)
{
  $targetResult = $line.Split(':')[0]
  $values = $line.Split(':')[1]

  $split = $values.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)
  
  $found = $false
  Test 0 '+' $split 0 $targetResult ([ref]$found)

  if($found -eq $true)
  {
    $totalSum += $targetResult
  }
}

Write-Host($totalSum)
