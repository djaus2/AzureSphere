@echo off
@echo .
@echo Get Existing Azure IoT Hub in Group %_groupname%
@echo.
@echo Getting list of IoT Hubs:
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

call az iot hub list --resource-group %_groupname% --output table > %locns1%

@echo    Location            Name            ResourceGroup    Resourcegroup    Subscriptionid
@echo    ------------------  --------------  ---------------  ---------------  ------------------------------------

more +2 %locns1% >%locns%
find "%_groupname%" /N %locns% > %menu%
Rem https://stackoverflow.com/questions/11428692/batch-file-to-delete-first-3-lines-of-a-text-file
more +2 %menu%>%menu2%

::Exit if no groups
findstr /R /N "^" %menu2% | find /C ":" > %tempFile1%
set /p "numlines="<%tempFile1%>nul
if "%numlines%" NEQ "0" goto GotGroups
@echo.
@echo No Azure IoT Hubs in Group "%_groupname%"
@echo.
IF EXIST %tempFile% (   del /q %tempFile% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %locns% (   del /q %locns% )
IF EXIST %locns1% (   del /q %locns1%)
IF EXIST %menu% (   del /q %menu% )
EXIT /B 1

:GotGroups
type %menu2%
SET /P numb= Enter IoT Hub Num:
set /a num=%numb%-1
more +%num% <%locns%>%tempFile%
set /p "_iothubname2="<%tempFile%>nul
@echo IoT Hub Chosen: %_iothubname2%
set "_iothubName="    
rem https://superuser.com/questions/918167/how-to-extract-second-word-of-the-string-via-windows-batch
for /f "tokens=2" %%i in ("%_iothubname2%") do set _iothubname=%%i
@echo.
@echo Group Name: %_iothubname%


IF EXIST %tempFile% (   del /q %tempFile% )
IF EXIST %tempFile1% (   del /q %tempFile1% )
IF EXIST %locns% (   del /q %locns% )
IF EXIST %locns1% (   del /q %locns1%)
IF EXIST %menu% (   del /q %menu% )
IF EXIST %menu2% (   del /q %menu2% )
