@echo off
cls
@echo.
@echo Welcome to the scripts for getting and even quicker start with Azure Sphere.
@echo These require AzureSphere to be installed and to be running at the Azsphere Developer Command Prompt
@echo Ref: https://docs.microsoft.com/en-us/azure-sphere/install/overview
@echo.
@echo Actions this script:
@echo [1] Setup azure CLI
@echo [2] Setup AzureSphere SDK
@echo [3] Setup Active Directory Account
@echo The three setup actions in this script refer you to a web page (one for each). 
@echo Follow the steps on those pages. The other two scripts (The ClaimYourDevice.bat and Azs.bat script their actions for you.)
@echo This script will guide you through the setup.
@echo This script does refer you to Actice Directory setup
@echo.
@echo Do yo wish to consult the MS docs Quickstart before starting here?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2"  GOTO NEXT
start microsoft-edge:https://docs.microsoft.com/en-us/azure-sphere/install/overview

:NEXT
@echo.
@echo Do you wish to continue with this SetUp script?
@echo Continue or Exit?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2"  exit /b 1


@echo.
:AZURECLI
@echo [1] Setup azure CLI
@echo Continue(Yes) or Skip?
choice /c:YN /M "Yes or Skip"
IF "%ERRORLEVEL%"=="2"  GOTO AZURESPHERE
@echo Perform the the actions on the following pagethen return to this prompt
Pause
start microsoft-edge:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest


@echo.
:AZURESPHERE
@echo [2] Setup AzureSphere SDK
@echo Continue (Yes) or Skip?
choice /c:YN /M "Yes or Skip"
IF "%ERRORLEVEL%"=="2"  GOTO SETUPACCOUNT
@echo Only do the page that shows 
@echo Then return to this prompt.
@echo.
Pause
start microsoft-edge:https://docs.microsoft.com/en-us/azure-sphere/install/install

@echo.
:SETUPACCOUNT
@echo [3] Setup Active Directory Account
@echo Continue (Yes) or Skip?
choice /c:YN /M "Yes or Skip"
IF "%ERRORLEVEL%"=="2"  GOTO DONE
@echo Only do the page that shows 
@echo Nb: The Claim Your Device action is covered by the ClaimYourDevice.bat script here, so don't take that link when done on that page, unless you want to do it manually yourself.
@echo.
Pause
start microsoft-edge:https://docs.microsoft.com/en-us/azure-sphere/install/azure-directory-account

:DONE
@cho Now run ClaimYourDevice.bat to setup tenneting from this command prompt then run azs.bat to configure Azure IoTHub for the device.
@echo DONE