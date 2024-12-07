$result = get-content .\input_example.txt

foreach ($line in $result)
{
  $targetResult = $line.Split(':')[0]
  $values = $line.Split(':')[1]

  $split = $values.Split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)

  $numOperators = $split.Count - 1
  $operators = New-Object bool[][] ($numOperators, ($numOperators * $numOperators))
  Write-Host($operators.Count)

  # T T
  # F F
  # T F
  # F T

  # T T T
  # F F F
  # T F T
  # F T F
  # T T F
  # F F T
  # T F F
  # F T T

  for($i = 0; $i -lt $numOperators; $i++)
  {
    for($j = 0; $j -lt ($numOperators * $numOperators) ; $j++)
    {
      $operators[$i][$j] = ($j * $i + $j) % 2 -eq 0 
    }
  }


  foreach($operator in $operators)
  {
    #Write-Host($operator)
  }

  # foreach($outer in $values.Split(' '))
  # {
  #   foreach($inner in $values.Split(' '))
  #   {
  #     if($inner -ne $outer)
  #     {
  #        
  #     }
  #   }
}

