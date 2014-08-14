This setup script cleans and imports voter data and election history data from http://election.dos.state.fl.us/ (usually sent as DVDs) into an indexed relational database.

####REQUIREMENTS
------------
1. Powershell 3.0 or higher
2. Postgres SQL


###STEPS
----------
Unzip the files and place it under appropriate folders under 'data' directory

####IMPORT VOTERS DETAILS

Please note, the data from the dept of elections has bad encoding and missing integer values. To make sure that the import is done correctly, cleaning is recommended

####TO CLEAN AND IMPORT

1. Place voter extract .txt files in any location other than data/voterextract
2. Open Powershell and navigate to /setup/voterextract folder
3. Run the following 
setup.ps1 -u <username> -db <databasename> -p <port> -clean 1 -dirtypath <location of files that need to cleaned> -cleanpath <loation to place the clean files>

####TO IMPORT CLEAN FILES
1. Place extracted clean files in data/voterextract folder
2. Open Powershell and navigate to /setup/voterextract folder
3. Run the following
```
	setup.ps1 -u <username> -db <databasename> -p <port> -cleanpath <loation to place the clean files>
```
Additional parameters
Add -nuke 1 to drop existing database and start from scratch

####IMPORT VOTER HISTORY
The history files are fairly clean and could be imported without cleaning. There may be files that do not get imported correctly.

1 . Place extracted files in data/voterhistory folder
2. Open Powershell and navigate to /setup/history folder
3. Run the following
```
	setup.ps1 -u <username> -db <databasename> -p <port> -path <loation to place the files>
```
	
