$app = $OctopusParameters["Octopus.Action[Dep].Output.app"]
Write-Host "Go to the directory $app "
cd $app

$maximumRuntimeSeconds = 45 
$process = Start-Process  dotnet -ArgumentList 'MusicStore.dll' -PassThru

Timeout 7
curl http://localhost:5000 -UseBasicParsing

try 
{
    $process | Wait-Process -Timeout $maximumRuntimeSeconds -ErrorAction Stop 
    Write-Warning  'Process successfully completed within timeout.' 
}
catch 
{
    Write-Host "It's is time to kill the Process." 
    $process | Stop-Process -Force 
} 