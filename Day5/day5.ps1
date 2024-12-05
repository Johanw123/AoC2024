$lines = Get-Content -Path .\input.txt
$list = New-Object Collections.Generic.List[String]
$list_correct = New-Object Collections.Generic.List[String]

foreach ($line in $lines)
{
  if($line.Contains(","))
  {
    $list.Add($line)
    $list_correct.Add($line)
  }
}

$loop = $true
while($loop)
{
  $loop = $false
  foreach ($line in $lines)
  {
    if($line.Contains("|"))
    {
      $pre = $line.Split("|")[0]
      $post = $line.Split("|")[1]

      for($i = 0; $i -lt $list.Count; $i++)
      {
        $a = $list[$i].Contains($pre)
        $b = $list[$i].Contains($post)

        if($a -and $b -and $list[$i].IndexOf($pre) -gt $list[$i].IndexOf($post))
        {
          $list_correct.Remove($list[$i])

          $list[$i] = $list[$i].Replace($post, "post")
          $list[$i] = $list[$i].Replace($pre, "pre")
          $list[$i] = $list[$i].Replace("pre", $post)
          $list[$i] = $list[$i].Replace("post", $pre)

          $loop = $true
        }
      }
    }
  }
}

$sum_correct = 0
$sum_incorrect = 0

foreach($update in $list_correct)
{
  $sum_correct += $update.Split(",")[[math]::Floor($update.Split(",").Length / 2)]
}
foreach($update in $list.Where({!$list_correct.Contains($_)}))
{
  $sum_incorrect += $update.Split(",")[[math]::Floor($update.Split(",").Length / 2)]
}

Write-Host $sum_correct #part1
Write-Host $sum_incorrect #part2
