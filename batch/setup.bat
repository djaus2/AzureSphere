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
@echo The three setup actions in this script refer you to a web page (one for each), after a test to see if they are installed, first.
@echo Follow the steps on those pages. The other two scripts (The ClaimYourDevice.bat and Azs.bat script their actions for you.)
@echo This script will guide you through the setup. It does now refer you to Actice Directory setup
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
cls
@echo [1] Setup azure CLI
call az --version
@echo.
@echo Is Az CLI setup? 
@echo Last line should be:
@echo Legal docs and information: aka.ms/AzureCliLegal
@echo.
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1"  GOTO AZURESPHERE
@echo.
@echo Setup Az CLI(Yes) or Skip?
choice /c:YN /M "Yes or Skip"
IF "%ERRORLEVEL%"=="2"  GOTO AZURESPHERE
@echo Perform the the actions on the following pagethen return to this prompt
Pause
start microsoft-edge:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest


@echo.
:AZURESPHERE
cls
@echo [2] Setup AzureSphere SDK
call "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
call azsphere -?
@echo.
@echo Is AzSphere setup? 
@echo First line should be:
@echo Azure Sphere Utility version "Version #"
@echo.
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1"  GOTO SETUPACCOUNT
@exho Setup AzSphere(Yes or Skip?
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
cls
@echo [3] Setup Active Directory Account
@echo To find out whether you have an account run azsphere login and sign in to Azure Sphere with your work or school account.
@echo In response, azsphere prompts you to pick an account. Choose your work/school account and type your password if required.
@echo If login succeeds, the command returns a list of the Azure Sphere tenants that are available for you. 
@echo If you are the first in your organization to sign in, you will not see any tenants.
@echo The test command will follow:
Pause
call "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
call azsphere login
@echo.
@echo Is AD for AzSpere setup?
@echo.
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1"  GOTO DONE
@echo Go to MS Docs web page for AD setup instructions?
@echo Continue (Yes) or Skip?
choice /c:YN /M "Yes or Skip"
IF "%ERRORLEVEL%"=="2"  GOTO DONE
@echo Only do the page that shows 
@echo Nb: The Claim Your Device action is covered by the ClaimYourDevice.bat script here, so don't take that link when done on that page, unless you want to do it manually yourself.
@echo.
Pause
start microsoft-edge:https://docs.microsoft.com/en-us/azure-sphere/install/azure-directory-account

:DONE
@echo Now run ClaimYourDevice.bat to setup tenneting from this command prompt then run azs.bat to configure Azure IoTHub for the device.
@echo DONE