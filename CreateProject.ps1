#
# FileName  : CreateProject.ps1
# Date      : 02/08/2018
# Author    : Arthur A. Garcia
# Purpose   : This script will create a project in VSTS and add groups to the
#             project. 
#

#import modules
$modName = $PSScriptRoot + ".\ProjectAndGroup.psm1" 
Import-Module -Name $modName

$modName = $PSScriptRoot + ".\Helper.psm1" 
Import-Module -Name $modName

$modName = $PSScriptRoot + ".\SecurityHelper.psm1" 
Import-Module -Name $modName

# get parameter data for scripts
$UserDataFile = $PSScriptRoot + "\ProjectDef.json"
$userParameters = Get-Content -Path $UserDataFile | ConvertFrom-Json

Write-Output $userParameters.ProjectName
Write-Output $userParameters.Description

# create project
CreateVSTSProject -userParams $userParameters

# add teams to project
AddProjectTeams -userParams $userParameters

# add vsts groups and all users
AddVSTSGroupAndUsers -userParams $userParameters 

