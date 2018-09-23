@echo off
@echo.
@echo Setup Active Directory Domain Tenant and Claim Device
@echo This requires AzureSphere to be installed and to be running at the Azsphere Developer Command Prompt
@echo Ref: https://docs.microsoft.com/en-us/azure-sphere/quickstart/qs-install
@echo.
@echo Continue?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2"  exit /b 1

set _nnn=137
set default-tenant-name=my-azsphere-ad-tenant
@echo.
@echo Default AD Tenant Name= %default-tenant-name%-nnn
@echo where nnn=%_nnn%
@echo.
SET /P _nnn= Enter new value for nnn (default=%_nnn%):
@echo nnn=%_nnn%
@echo.

set default-tenant-name=%default-tenant-name%-%_nnn%
@echo Default AD Tenant Name= %default-tenant-name%

@echo.

@echo Are you already logged into Azure Sphere (PS this is separate to Azure CLI (Az))?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2"  GOTO DEVPROMPT
@echo azsphere tenant list
azsphere tenant list
@echo In the text above, did get the message indicate you were Tenanted? Eg:
@echo "ID                                   Name         "
@echo "--                                   ----         "
@echo "<Guid>                               <Domain Name>"
@echo All ready AAD Tenanted?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" goto CONTINUE789
@echo Must already have Tenant so go straight to claim device:
azsphere tenant list
GOTO CLAIM

:DEVPROMPT
@echo Loading Azsphere Developer Command Prompt: "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
call "C:\Program Files (x86)\Microsoft Azure Sphere SDK\\InitializeCommandPrompt.cmd"
@echo Loaded Azsphere Developer Command Prompt

:AzSLogIn
azsphere login

:PROMPT101
@echo. ?????????????????????????????????????
@echo In the text above, did get the message indicate you were Tenanted Eg:
@echo "The selected Azure Sphere tenant '<DOMAINNAME>' (<GUID>) will be retained."
@echo "Successfully logged in with the selected AAD user. This authentication will be used for subsequent commands."
@echo All ready AAD Tenanted?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" goto CONTINUE789
@echo Must already have Tenant so go straight to claim device AAD Tenant:
azsphere tenant list
GOTO CLAIM

:CONTINUE789

@echo.
@echo You need to be Azure Active Directory Tenanted. Create new AAD Tenant
@echo.
@echo NOTE:
@echo By default, azsphere allows one tenant per Azure Active Directory (AAD). 
@echo If you already have a tenant and are certain you want another one, use the --force parameter. 
@echo Currently, you cannot delete an Azure Sphere tenant.
@echo NB: If you use force to change the tenant you may "lose" devices on the current tenant.
@echo Do you wish to create the new Tenant
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1" goto CONTINUE790
@echo Aborting device claim (1)
exit /b 3

:CONTINUE790

echo .
@echo [2.2] Get Active Directory Tenant Name
@echo.
@echo Default Tenant Name: %default-tenant-name%
set _tenantname=
SET /P _tenantname= Enter AD Tenant Name:
IF "%_tenantname%Z"=="Z" GOTO DEFAULT791
GOTO CONTINUE791
:DEFAULT791
SET  _tenantname=%default-tenant-name%

:CONTINUE791

@echo.
@echo azsphere tenant create --name %_tenantname%
azsphere tenant create --name %_tenantname%

@echo Did that work OK?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" exit /b 5

:CLAIM
@echo.
@echo NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE 
@echo.
@echo Tenanting is a once only and irreversable action.
@echo The device can not be reteneted.
@echo If you wish to proceeed please confirm again.
@echo.
@echo NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
Echo.
choice /c:YN /M "Claim device Yes or No"
IF "%ERRORLEVEL%"=="1"  GoTo CONTINUE792
@echo Aborting device claim (2)
exit /b 4


:CONTINUE792

@echo.
@echo Device must now be connected over USB
@echo.
@echo Do you really wish to claim your device? (This is a once only irreversible action.) Last chance to abort!
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="1" goto CONTINUE793
@echo Aborting device claim (1)
exit /b 3

:CONTINUE793
azsphere device claim
@echo Did that work OK?
choice /c:YN /M "Yes or No"
IF "%ERRORLEVEL%"=="2" exit /b 5

:TENETED
@echo.
@echo Device was claimed.
@echo.
azsphere tenant list
exit /b /0

:DONE