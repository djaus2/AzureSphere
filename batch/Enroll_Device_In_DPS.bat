@echo off
@echo.
@echo Enroll Device in Device Provis:on Service
@echo.
@echo This requires AzureSphere to be installed and to be running at the Azsphere Developer Command Prompt
@echo Ref: https://docs.microsoft.com/en-us/azure-sphere/quickstart/qs-install
@echo.
@echo Also assumes Azure CLI is installed
@echo Ref: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
@echo.
@echo Continue?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2"  exit /b

@echo Are you already logged into Azure Sphere (PS this is separate to Azure CLI (Az))?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1"  GOTO AzSLoggedIn

@echo Loading Azsphere Developer Command Prompt: "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
call "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
@echo Loaded Azsphere Developer Command Prompt
:AzSLoggedIn

azsphere login
@echo. ?????????????????????????????????????
@echo When you logged in, did the message indicate you were Teneted Eg:
@echo Typical message "The selected Azure Sphere tenant '<DOMAINNAME>' (<GUID>) will be retained.
@echo Successfully logged in with the selected AAD user. This authentication will be used for subsequent commands."
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1" GoTo TENETED
@echo.
@echo You need to be teneted. Please Claim your device first
@echo.
@echo Do you wish to claim your device? (This is a once only irreversible action.)
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" exit /b 1
cls
@echo.
@echo NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE 
@echo.
@echo Teneting is a once only and irreversable action and so is not automatically actioned as part of this batch file.
@echo If you wish to proceeed please confirm again.
@echo.
@echo NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE 
choice /c:YN /M "Claim device Yes or No"
IF "%ERRORLEVEL%"=="2" exit /b 1

azspehere tenant create --name %my-tenant-name%
azsphere device claim
@echo Did that work OK?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" exit /b 1

:TENETED
@echo.
@echo Device was claimed.
@echo.
azsphere tenant download-CA-certificate --output CAcertificate.cer

echo az iot dps certificate create  --dps-name %_dvps% --resource-group %_groupname%  --name MyCertificate --path CAcertificate.cer
exit /b


:DONE