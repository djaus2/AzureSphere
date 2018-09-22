@echo off
@echo .
@echo Get Azure Locations that provide IoT Hubs
@echo.
@echo "Number of Azure IoT Hub Locations < Total number of Azure Locations"
@echo.
set locns="Locations"
set locns1="Locations1.txt"
set menu="menu.Txt"
set menu1="menu1.Txt"
call az provider show --namespace Microsoft.Devices --query "resourceTypes[?resourceType=='IotHubs'].locations | [0]" --out table >%locns1%
more +2 %locns1% >%locns%
find " " /N %locns% > %menu1%
more +2 %menu1% >%menu%
type %menu%
SET /P numb= Enter Location Num:
set /a num=%numb%-1
more +%num% <%locns% >file.tmp
set /p "_locationName="<file.tmp >nul
@echo Location Chosen: %_locationName%
del file.tmp
del %menu%
del %locns%
del %menu1%
del %locns1%
