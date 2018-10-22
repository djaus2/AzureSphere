@echo off
@echo.
@echo Selecting IoT Hub subscription level
@echo.
REM Value returned in -sku environment variable
@echo Select one of the IoT Hub subscription types:
@echo B1, B2, B3, F1, S1, S2, S3
@echo.
@echo See https://azure.microsoft.com/en-us/pricing/details/iot-hub/ 
@echo   for SKU pricing details
@echo.
@echo No Bx in this process. (Basic: No Edge, NoDevice Provisioning)	
@echo Bx are Basic Tiers, Sx are Standard Tiers
echo.
@echo Note only one Free (F1) per Azure subscription permitted
@echo.
:START4
set _sku=
set /p _sku=Type the sku(Enter one of F1, S1, S2, S3): 

if  "%_sku%Z"=="Z" GOTO START4

CALL :UpCase _sku

if "%_sku%"=="F1" goto OK4
if "%_sku%"=="S1" goto OK4
if "%_sku%"=="S2" goto OK4
if "%_sku%"=="S3" goto OK4
  GOTO  START4

:OK4
@echo.
@echo SKU chosen is %_sku%
@echo.
goto Done
=======================================================================================
REM Upper/Lowercase routines from : http://www.robvanderwoude.com/battech_convertcase.php
REM =======================================================================================


:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "%1=%%%1:%%~i%%"
   EXIT /B

:UpCase
:: Subroutine to convert a variable VALUE to all UPPER CASE.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO CALL SET "%1=%%%1:%%~i%%"
  EXIT /B

:TCase
:: Subroutine to convert a variable VALUE to Title Case.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN (" a= A" " b= B" " c= C" " d= D" " e= E" " f= F" " g= G" " h= H" " i= I" " j= J" " k= K" " l= L" " m= M" " n= N" " o= O" " p= P" " q= Q" " r= R" " s= S" " t= T" " u= U" " v= V" " w= W" " x= X" " y= Y" " z= Z") DO CALL SET "%1=%%%1:%%~i%%"
  EXIT /B

:DONE