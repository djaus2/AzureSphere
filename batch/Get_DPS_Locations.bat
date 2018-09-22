
@echo off
@echo.
@echo Get Azure Locations that provide Device Provision Services
@echo.
@echo "Number of Azure DPS Locations < Number of Azure IoT Hub Locations" 
@echo.
set locns="Locations"
set locns1="Locations1.txt"
set menu="menu.Txt"
set menu1="menu1.Txt"
call az provider show --namespace Microsoft.Devices --query "resourceTypes[?resourceType=='ProvisioningServices'].locations | [0]" --out table >%locns1%
more +2 %locns1% >%locns%
find " " /N %locns% > %menu1%
more +2 %menu1% >%menu%
type %menu%
SET /P numb= Enter Location Num:
set /a num=%numb%-1
more +%num% <%locns% >file.tmp
set /p "_dvpsLocation="<file.tmp >nul
@echo Location Chosen: %_dvpsLocation%
del file.tmp
del %menu%
del %locns%
del %menu1%
del %locns1%