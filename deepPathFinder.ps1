$script:exclude = @();
function getExclude {
  $lastExcludeEntry = "";
  if($exclude.Count -eq 0) {$lastExcludeEntry = Read-Host "Enter excluded directories";}
  else {$lastExcludeEntry = Read-Host "More?";}
  if($lastExcludeEntry -ne ""){
    $script:exclude += $lastExcludeEntry;
    getExclude;
  }
}


function getDepth {
  $script:maxDepth = [int](Read-Host "What depth?");
  if(($script:maxDepth.GetType().FullName) -ne ((2).GetType().FullName)) {
    Write-Host "Depth must be an integer";
    getDepth;}
}

$spath = Read-Host "Which path?";
getDepth;
Write-Host ""
Write-Host "Press enter on an empty line to finish the exclusion list"
getExclude;

Write-Host ""
Write-Host "Scanning...";

$longPaths=@();
$pathDepth=($spath -split '[\\/]').Count;

(ls $spath -Directory -Recurse -Depth ($script:maxDepth)) |
  %{
    $bob=$true;
    $splCD = $_.FullName.split('\');
    foreach($itm in $splCD) {
      if($itm -in $script:exclude) {
        $bob=$false;
      }
    }
    if($bob){
      if(($_.FullName -split '[\\/]').Count -gt ($pathDepth-1+$script:maxDepth)) {$longPaths+=$_.FullName;}
    }
  };

$longPaths
Write-Host "------- Found " $longPaths.Count " deeply nested folders"