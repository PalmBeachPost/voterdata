# This script cleans the voterextract file by removing unneccessary '\' that mess up import to postgres
get-childitem ..\data\voterextract\*.txt -File -Recurse |
foreach {
    $outPath = '..\data\clean\voterextract' +$_.name 
    Get-Content $_ | 
    ForEach-Object {
        $_ -replace "\\","" 
    } |  
    Out-File -encoding 'UTF8' -filepath $outPath
}