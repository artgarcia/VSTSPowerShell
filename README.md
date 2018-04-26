# VSTSPowerShell

This set of PowerShell scripts will allow you to manage and create a VSTS project. The following files are included.

CreateProject.ps1 - This file will control the adding of a project
                                           adding teams to the project
                                           adding VSTS groups
                                           adding a Git Repo
                                           adding security to groups within the project
                                           
ProjectDej.json - This json file will hold the parameters needed to create a project, add teams, users and security
                  It also includes the PAT or Personal access token needed to connect to the VSTS instance.
                  
ProjectAndGroup.psm1 - this Module contains the functions needed for the project

Helper.psm1 - this module contains helper functions

SecurityHelper.psm1 - this module contains security related functions
