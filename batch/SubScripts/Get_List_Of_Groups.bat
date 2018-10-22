@echo off
@echo .
@echo Get Existing Azure Group Name
@echo.
@echo Getting list of Groups:
@echo.

set tempFile="temp.txt"
set tempFile1="temp1.txt"
set locns="Groups3.txt"
set locns1="Groups4.txt"
set menu="Group.Txt"
set menu2="Groups2.Txt"

IF EXIST %tempFile% (   del /q %tempFile% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %locns% (   del /q %locns% )
IF EXIST %locns1% (   del /q %locns1%)
IF EXIST %menu% (   del /q %menu% )
IF EXIST %menu2% (   del /q %menu2% )


@echo    Name                               Location            Status
@echo    ---------------------------------  ------------------  ---------
call az group list --output table>>%locns1%
more +2 %locns1% >%locns%
find "Succeeded" /N %locns% > %menu%
Rem https://stackoverflow.com/questions/11428692/batch-file-to-delete-first-3-lines-of-a-text-file
more +2 %menu% >%menu2%

::Exit if no groups
findstr /R /N "^" %menu2% | find /C ":" > %tempFile1%
set /p "numlines="<%tempFile1%>nul
if "%numlines%" NEQ "0" goto GotGroups
@echo.
@echo No Azure Groups for Log In
@echo Does it have a subscription?
@echo.
IF EXIST %tempFile% (   del /q %tempFile% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %locns% (   del /q %locns% )
IF EXIST %locns1% (   del /q %locns1%)
IF EXIST %menu% (   del /q %menu% )
EXIT /B 1

:GotGroups
type %menu2%
SET /P numb= Enter Group Num:
set /a num=%numb%-1
more +%num% <%locns% >%tempFile%
set /p "_groupname2="<%tempFile% >nul
REM https://stackoverflow.com/questions/24225742/setting-a-variable-with-the-first-word-from-another-variable
@echo Group Chosen: %_groupname2%
set "_groupname="    
for %%h in ( %_groupname2%) do if not defined _groupname set "_groupname=%%h"
@echo.
@echo Group Name: %_groupname%


IF EXIST %tempFile% (   del /q %tempFile% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %locns% (   del /q %locns% )
IF EXIST %locns1% (   del /q %locns1%)
IF EXIST %menu% (   del /q %menu% )
IF EXIST %menu2% (   del /q %menu2% )
:Done
