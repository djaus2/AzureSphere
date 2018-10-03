# Djs Azure Sphere Scripts

You have an Azure Sphere and want to get cracking with it
ASAP! You can do so by following the documentation on docs.microsoft.com.
There’s quite a bit to get through and much of it is of the format do this then
do that then … . But it does seem a bit mechanical in that if, having done it
once and had to do it again in a new environment, the actions would be largely
the same. So couldn’t some or a significant amount of it be automated, or at
least scripted?



This GitHub repository contains a number of scripts, as DOS
batch files, that do simplify this procedure. Where user input is required a
user prompt for input occurs. Where the user needs to make a choice from
existing Azure or other resources, a numbered list is auto-generated, with
selection being made by choosing the item number. 



There are currently two main scripts:



One for setting up the Active Directory Tenant
for, and including  the device,

One for setting up the Azure IoT Hub, ddService
and connecting the device to it





There are a number of other scripts that are called by these
two scripts, each with a specific function. In the main, parameters are passed
to these from the main scripts as environment variables. All subscript results
are passed back as environment variables that are then used by the main scripts
as parameters to Azure calls.



Currently the scripts do address setting up the required
Active Directory. Consult the Microsoft documentation for this. This may be
added later. I used my AD from my Office 365 subscription (ominmicrosft.com)
for which I use my domain name (sportronics.com.au)



Whilst these scripts are DOS Batch files, it is envisaged
that a subsequent version with use Powershell.




