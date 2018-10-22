@echo off
cls
@echo [0] Default Names 
@echo The steps for this script are:
@echo [1] Logging in to Azure
@echo [2] Setting Azure Group
@echo [2.1] Get existing Azure Group Name
@echo [2.2] Get new Azure Group Name
@echo [3] Creating new IoT Hub
@echo [4] Creating the IoT Hub Device Provisioning Service
@echo [4.1] Get new DVPS Name
@echo [4.2] Get new DVPS Location
@echo [5] Link the IoT Hub to The Device Provisioning Service
@echo.
pause
@echo [0] Default Names 
@echo Nb: If a name is requested, just press enter to use these.
@echo.
set _nnn=137

set defaultGroupName=my-azsphere-group
set defaultIoTHub=My-IoT-Hub
set defaultDVPS=My-DevProvSvc
@echo Default Group Name= %defaultGroupName%-nnn
@echo Default IoT Hub Name= %defaultIoTHub%-nnn
@echo Default Device Provison Service Name= %defaultDVPS%-nnn
@echo where nnn=%_nnn%
@echo.
SET /P _nnn= Enter new value for nnn (default=137):
@echo nnn=%_nnn%
@echo.

set defaultGroupName=%defaultGroupName%-%_nnn%
set defaultIoTHub=%defaultIoTHub%-%_nnn%
set defaultDVPS=%defaultDVPS%-%_nnn%

@echo Default Group Name= %defaultGroupName%
@echo Default IoT Hub Name= %defaultIoTHub%
@echo Default Device Provison Service Name= %defaultDVPS%
@echo.

@echo [1] Logging in to Azure
@echo Are you already logged into Azure here?
choice /c:YN /M "Yes or No"
@echo %ERRORLEVEL% 
IF "%ERRORLEVEL%"=="1"  goto GROUP
rem start microsoft-edge:https://microsoft.com/devicelogin
call az login

:GROUP
@echo [2] Setting Azure Group
@echo Do you want to create a new group (N), use an existing one (E), or skip?
choice /c:NES /M "New, Existing, or Skip"
@echo %ERRORLEVEL% 
IF "%ERRORLEVEL%"=="1"  goto NEWGROUP
IF "%ERRORLEVEL%"=="3"  goto HUB

@echo ===========================================================


@echo .
@echo [2.1] Get existing Azure Group Name
@echo.
@echo Getting list of Groups:
goto skip5678

call az group list --output table
:DEFAULT2
@echo Select existing group from list (in left column)
set _groupname=
SET /P _groupname= Enter Group Name:
IF "%_groupname%Z"=="Z" GOTO DEFAULT2

:skip5678
call .\Subscripts\Get_List_Of_Groups

if NOT ERRORLEVEL 1  GOTO GOTGRP
@echo Exiting
exit /B

   

@echo ===========================================================

:NEWGROUP

echo .
@echo [2.2] Get new Azure Group Name
@echo.
@echo Default Group Name: %defaultGroupName%
set _groupname=
SET /P _groupname= Enter Group Name:
IF "%_groupname%Z"=="Z" GOTO DEFAULT2
GOTO NEXT2
:DEFAULT2
SET  _groupname=%defaultGroupName%
:NEXT2

@echo ===========================================================

@echo.
@echo [2.3] Creating new Azure Group
@echo.

goto skip89
call az account list-locations -o table
@echo.
SET _locationName=
@echo Select a location from the 4th column
@echo Default Location: %defaultLoc%
set _locationName=
SET /P _locationName= Enter location:
IF "%_locationName%Z"=="Z" GOTO DEFAULT

GOTO NEXT1
:DEFAULT
SET  _locationName=
SET  _locationName=%defaultLoc%
:NEXT1

:skip89

call .\Subscripts\Get_IoTHub_Locations

@echo az group create --name %_groupname% --location "%_locationName%"
call az group create --name %_groupname% --location "%_locationName%"

:GOTGRP
call az configure --defaults group=%_groupname%

@echo ===========================================================

:HUB
echo.
@echo [3] Creating new IoT Hub
echo.

@echo Do you want to create a new IoT Hub(N), use an existing one (E) or skip (S)?
choice /c:NES /M "New, Existing, or Skip"
@echo %ERRORLEVEL% 
IF "%ERRORLEVEL%"=="1"  goto NEWHUB
IF "%ERRORLEVEL%"=="3"  goto DVPS

@echo Get list of Hubs for Group

call .\Subscripts\Get_List_Of_Hubs

if NOT ERRORLEVEL 1  GOTO DVPS
@echo Exiting
exit /B


:NEWHUB
@echo Default IoT Hub Name: %defaultIoTHub%
set _iothubname=
SET /P _iothubname= Enter IoT Hub Name:
IF "%_iothubname%Z"=="Z" GOTO DEFAULT3
GOTO NEXT3
:DEFAULT3
SET _iothubname=%defaultIoTHub%
@echo %_iothubname%
:NEXT3

Call .\Subscripts\Get_SKU

@echo SKU= %_sku%

echo az iot hub create --name %_iothubname% --resource-group %_groupname%   --sku %_sku%
call az iot hub create --name %_iothubname% --resource-group %_groupname%   --sku %_sku%
@echo.
@echo az iot hub list --resource-group %_groupname% -o Table
call az iot hub list --resource-group %_groupname% -o Table

@echo ===========================================================

:DVPS
@echo.
@echo [6] Creating the IoT Hub Device Provisioning Service
@echo .

@echo Do you want to create a new DVPS(N), use an existing one (E) or skip (S)?
choice /c:NES /M "New, Existing, or Skip"
@echo %ERRORLEVEL% 
IF "%ERRORLEVEL%"=="1"  goto NEWDVPS
IF "%ERRORLEVEL%"=="3"  goto LINK

@echo Getting exitsing Device Provision Service for Group  %_groupname%

   goto LINK

:NEWDVPS

@echo [4.1] Get new DVPS Name
@echo Default DVPS Name: %defaultDVPS%
set _dvps=
SET /P _dvps= Enter DVPS Name:
IF "%_dvps%Z"=="Z" GOTO DEFAULT6
GOTO NEXT6
:DEFAULT6
SET  _dvps= %defaultDVPS%
:NEXT6


@echo [4.2] Get new DVPS Location
@echo Getting list of suitable loactions:
call Get_DPS_Locations

echo az iot dps create --name %_dvps% --resource-group %_groupname% --location "%_dvpsLocation%"
call az iot dps create --name %_dvps% --resource-group %_groupname% --location "%_dvpsLocation%"

@echo Done DPS Create

@echo List Device Provsion Services for Resource Group: %_groupname% 
@echo az iot dps list --resource-group %_groupname% -o Table
call az iot dps list --resource-group %_groupname% -o Table

@echo ===========================================================

:LINK
@echo.
@echo [5] Link the IoT Hub to The Device Provisioning Service
@echo.

@echo Do you want link a Hub to the DVPS (Y),or skip (S)?
choice /c:YS /M "Yes or Skip"
@echo %ERRORLEVEL% 
IF "%ERRORLEVEL%"=="1"  goto DOLINK
   goto END

:DOLINK
call az iot hub show-connection-string --name %_iothubname% --key primary  -o tsv > cs.txt
set _cs=
set /p _cs= < cs.txt

@echo IoT Hub %_iothubname% Connection String =  %_cs%

@echo az iot dps linked-hub create --dps-name %_dvps% --resource-group %_groupname% --connection-string %_cs% --location "%_dvpsLocation%"
call az iot dps linked-hub create --dps-name %_dvps% --resource-group %_groupname% --connection-string %_cs% --location "%_dvpsLocation%"


@echo List Linked (Device Provsioned) IoT Hubs for Resource Group:  %_groupname% 
@echo az iot dps linked-hub list --dps-name %_dvps% --resource-group %_groupname% -o Table
call  az iot dps linked-hub list --dps-name %_dvps% --resource-group %_groupname% -o Table

:END
@echo.
@echo To delete the group (and all resources): az group delete   -g %_groupname%  --yes
@echo To delete just the hub:                  az iot hub delete -n %_iothubname%  
@echo To delete just the dvps:                 az iot dps delete -n %_dvps%  -g %_groupname% 
@echo To delete just the linked hub:    ??? TBD       az iot dps delete -n linked-hub  -g %_groupname%  
@echo To logout from Azure:                    az logout       
@echo.
@echo You need the Connection String for DeviceExplorer (Later)
@echo IoT Hub %_iothubname% Connection String = >HubConnectionstring.txt
@echo %_cs% >>HubConnectionstring.txt
@echo Saved as HubConnectionString.txt



:DONE