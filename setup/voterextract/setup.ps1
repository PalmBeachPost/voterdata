param(
    $u ='postgres',
    $p = 5432,
    $db = 'votersdb',
    $nuke = 0,
    $clean = 0,
    $dirtypath ='..\data\voterextract\*.txt',
    $cleanpath ='..\data\clean\voterextract\'
    )

$ErrorActionPreference ="stop"

if($nuke -eq 1)
{
    # Fesh start
    PSQL -U $u -h localhost -p $p -w -c "drop database if exists $db"
    CREATEDB -U $u $db

    # create tables
    PSQL -U $u -h localhost -p $p -w -d $db -f ./sql/createTables.sql
    del status.txt
    new-item status.txt -type file

}

if($clean -eq 1)
{
  get-childitem $dirtypath -File -Recurse |
  ForEach-Object {
    Add-content status.txt "$(Get-Date -f o) : Cleaning $_"
    write-host "Cleaning $_ " 
    $outPath = $cleanpath + $_.name 
    #if clean file exists,skip
    if(!(test-path $outpath))
    {
     $content = Get-Content $_ | 
      ForEach-Object {
          $_ -replace "\\","" 
      }
      # forcing removal of BOM. TODO: find a cleaner way
      $outpath = convert-path $outpath
      [System.IO.File]::WriteAllLines($outpath, $content)
      write-host "Saved cleaned-up file at" +$outPath    
      Add-content status.txt "$(Get-Date -f o) : Cleaned data placed at $outpath"
    }
  }
}

#get cleaned data CSVs and insert into tables
get-childitem $cleanpath -File -Recurse |
ForEach-Object {
  $folder = $_.fullname;
  Add-content status.txt "$(Get-Date -f o) : Importing $folder"
  PSQL -U $u -h localhost -p $p -w -d $db -v file="'$folder'" -f ./sql/importData.sql
  Add-content status.txt "$(Get-Date -f o) : finished importing $folder"
}

