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

getExclude;
$spath = Read-Host "What is the source path?";
$destination = Read-Host "What is the destination path?";

Copy-Item ($spath+"\*") -Destination $destination;

$newpath="";
ls $spath -Directory -Recurse | 
  %{
    $bob=$true;
    $splCD = $_.FullName.split('\');
    foreach($itm in $splCD) {
      if($itm -in $script:exclude) {
        $bob=$false;
      }
    }
    if($bob){
      $newpath = $_.FullName.replace($spath, $destination);
      $_.FullName;
      $newpath;
      Write-Host --------------
      Copy-Item ($_.FullName+"\*") -Destination ($newpath)
    }
  };
