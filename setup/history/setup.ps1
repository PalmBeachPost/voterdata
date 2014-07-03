param(
    $u ='postgres',
    $p = 5432,
    $db = 'votersdb',
    $nuke = 0,
    $path ='..\..\data\voterhistory\*'
    )

if ($nuke -eq 1)
{
    # create tables
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables.sql
    del status.txt
    new-item status.txt -type file
}

get-childitem $path -File -Recurse |
ForEach-Object {
  $folder = $_.fullname;
  write-host $folder
  Add-content status.txt "$(Get-Date -f o) : Importing $folder"
  PSQL -U $u -h localhost -p $p -w -d $db -v file="'$folder'" -f ./sql/importData.sql
  Add-content status.txt "$(Get-Date -f o) : finished importing $folder"
}

PSQL -U $u -h localhost -p $p -w -d $db ./sql/final.sql