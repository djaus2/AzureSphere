# Djs Azure Sphere Scripts

  

This documentation, like the repository itself, is a work in
progress.



You have an Azure Sphere and you want to get cracking with
it ASAP! You can do so by following the documentation on docs.microsoft.com.
There’s quite a bit to get through and much of it is of the format: Do this
then do that then … . But it does seem a bit mechanical in that if, having done
it once and had to do it again in a new environment, the actions would be
largely the same. So couldn’t some or a significant amount of it be automated,
or at least scripted?



This GitHub repository contains a number of scripts, as DOS
batch files, that do simplify this procedure. Where user input is required a
user prompt for input occurs. Where the user needs to make a choice from
existing Azure or other resources, a numbered list is auto-generated, with
selection being made by choosing the item number. 



There are currently three main scripts:

**Setup.bat** Guides you through setting up Azure CLI, AzureSphere command prompt and Active Directory.

**ClaimDevice.bat**..*(It's there now)* One for setting up
the Active Directory Tenant for, and including 
the device,

**AzsHub.bat** One for setting up the Azure IoT Hub Device
Provisioning Service and connecting the device to it

**Nb: NOTE THAT TENANTING OF AN AZURE SPHERE DEVICE IS ONCE
ONLY ACTION, NOT UNDO-ABLE, NOT CHANGEABLE, NOT REVERSABLE. SO TAKE CARE WITH
THAT SCRIPT. ALL CARE BUT NO RESPONSIBILITY AT THIS END.**



There are a number of other scripts that are called by these
two scripts, each with a specific function. In the main, parameters are passed
to these from the main scripts as environment variables. All subscript results
are passed back as environment variables that are then used by the main scripts
as parameters to Azure calls.

Each step in the two main scripts has a prompt so that you can skip the action if already done. That way if you are part way through a script you can restart it and skip to where you are up to. Also you can do a "dummy run that way.



Currently the scripts do not address setting up the required
Active Directory, but you are refered to the appropiate web page. I used my AD from my Office 365 subscription (ominmicrosft.com)
for which I use my domain name (sportronics.com.au)

Whilst these scripts are DOS Batch files, it is envisaged
that a subsequent version with use Powershell.

The scripts require the azure CLI (Command Line Interface)
to be installed as well as AzSphere. These are refered to in setup.bat



