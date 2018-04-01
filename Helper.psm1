#
# FileName : Helper.psm1
# Data     : 03/20/2018
# Purpose  : this module has helper methods
#


$project =  @{
    values = @(
        @{area="PROJECT"; displayName = "View project-level information"; bit = 1; name ="GENERIC_READ";}
        @{area="PROJECT"; displayName = "Edit project-level information"; bit = 2; name ="GENERIC_WRITE";}
        @{area="PROJECT"; displayName = "Delete team project"; bit =4; name ="DELETE";}
        @{area="PROJECT"; displayName = "Create test runs"; bit =8; name ="PUBLISH_TEST_RESULTS";}

        @{area="PROJECT"; displayName ="Administer a build"; bit=16; name ="ADMINISTER_BUILD";}
        @{area="PROJECT"; displayName ="Start a build"; bit=32; name ="START_BUILD"}        
        @{area="PROJECT"; displayName="Edit build quality"; bit=64; name ="EDIT_BUILD_STATUS";}
        @{area="PROJECT"; displayName="Write to build operational store"; bit=128; name ="UPDATE_BUILD";}

        @{area="PROJECT"; displayName = "Delete test runs"; bit =256; name ="DELETE_TEST_RESULTS";}
        @{area="PROJECT"; displayName = "View test runs"; bit =512; name ="VIEW_TEST_RESULTS";}
        @{area="PROJECT"; displayName = "Manage test environments"; bit =2048; name ="MANAGE_TEST_ENVIRONMENTS";}
        @{area="PROJECT"; displayName = "Manage test configurations"; bit =4096; name ="MANAGE_TEST_CONFIGURATIONS";}
        @{area="PROJECT"; displayName = "Delete and restore work items"; bit =8192; name ="WORK_ITEM_DELETE";}
        @{area="PROJECT"; displayName = "Move work items out of this project"; bit =16384; name ="WORK_ITEM_MOVE";}
        @{area="PROJECT"; displayName = "Permanently delete work items"; bit =32768; name ="WORK_ITEM_PERMANENTLY_DELETE";}
        @{area="PROJECT"; displayName = "Rename team project"; bit =65536; name ="RENAME";}
        @{area="PROJECT"; displayName = "Manage project properties"; bit =131072; name ="MANAGE_PROPERTIES";}
        @{area="PROJECT"; displayName = "Bypass rules on work item updates"; bit =1048576; name ="BYPASS_RULES";}

        @{area="PROJECT"; displayName = "Bypass project property cache"; bit=524288; name ="BYPASS_PROPERTY_CACHE";} 
        @{area="PROJECT"; displayName = "Suppress notifications for work item updates"; bit =2097152; name ="SUPPRESS_NOTIFICATIONS";}

        @{area="BUILD";bit=1; name="ViewBuilds"; displayName="View builds";}
        @{area="BUILD";bit=2; name="EditBuildQuality"; displayName="Edit build quality";}
        @{area="BUILD";bit=4; name="RetainIndefinitely"; displayName="Retain indefinitely"; }
        @{area="BUILD";bit=8; name="DeleteBuilds"; displayName="Delete builds";}
        @{area="BUILD";bit=16; name="ManageBuildQualities"; displayName="Manage build qualities"; }
        @{area="BUILD";bit=32; name="DestroyBuilds"; displayName="Destroy builds";}
        @{area="BUILD";bit=64; name="UpdateBuildInformation"; displayName="Update build information";}
        @{area="BUILD";bit=128; name="QueueBuilds"; displayName="Queue builds"; }
        @{area="BUILD";bit=256; name="ManageBuildQueue"; displayName="Manage build queue";}
        @{area="BUILD";bit=512; name="StopBuilds"; displayName="Stop builds";}
        @{area="BUILD";bit=1024; name="ViewBuildDefinition"; displayName="View build definition"; }
        @{area="BUILD";bit=2048; name="EditBuildDefinition"; displayName="Edit build definition";}
        @{area="BUILD";bit=4096; name="DeleteBuildDefinition"; displayName="Delete build definition"; }
        @{area="BUILD";bit=8192; name="OverrideBuildCheckInValidation"; displayName="Override check-in validation by build"; }
        @{area="BUILD";bit=16384; name="AdministerBuildPermissions"; displayName="Administer build permissions";}

        @{area="ReleaseManagement"; displayName = "View release definition"; bit=1; name="ViewReleaseDefinition";}
        @{area="ReleaseManagement"; displayName = "Edit release definition"; bit=2; name="EditReleaseDefinition";}
        @{area="ReleaseManagement"; displayName = "Delete release definition"; bit=4; name="DeleteReleaseDefinition";}
        @{area="ReleaseManagement"; displayName = "Manage release approvers"; bit=8; name="ManageReleaseApprovers";}
        @{area="ReleaseManagement"; displayName = "Manage releases"; bit=16; name="ManageReleases";}
        @{area="ReleaseManagement"; displayName = "View releases"; bit=32; name="ViewReleases";}
        @{area="ReleaseManagement"; displayName = "Create releases"; bit=64; name="CreateReleases";}
        @{area="ReleaseManagement"; displayName = "Edit release environment"; bit=128; name="EditReleaseEnvironment";}
        @{area="ReleaseManagement"; displayName = "Delete release environment";bit=256; name="DeleteReleaseEnvironment";}
        @{area="ReleaseManagement"; displayName = "Administer release permissions";bit=512; name="AdministerReleasePermissions";}
        @{area="ReleaseManagement"; displayName = "Delete releases";bit=1024; name="DeleteReleases";}
        @{area="ReleaseManagement"; displayName = "Manage deployments";bit=2048; name="ManageDeployments";}
        @{area="ReleaseManagement"; displayName = "Manage release settings";bit=4096; name="ManageReleaseSettings";}
    )
}


function Get-PermissionBit(){
    param(
        [Parameter(Mandatory = $true)]
        $Permission
    )

    $fnd = $project.values | Where-Object {$_.name -eq $Permission}
    return $fnd
}



function Get-GroupDescriptor () {
    param(
        [Parameter(Mandatory = $true)]
        $userParams,
        [Parameter(Mandatory = $true)]
        $groupName
    )

    $grpInfo =  Get-GroupInfo -userParams $userParams -groupName $groupName
    IF (![string]::IsNullOrEmpty($grpInfo)) {

         
        # Base64-encodes the Personal Access Token (PAT) appropriately
        $authorization = GetVSTSCredential -Token $userParams.PAT -userEmail $userParams.userEmail

        # find groups
        #$projectUri = "https://" + $userParams.VSTSMasterAcct + ".vsaex.visualstudio.com/_apis/groupentitlements/"+ $grpInfo.originId + "?api-version=4.1-preview"
        #$grpEntitlments = Invoke-RestMethod -Uri $projectUri -Method Get -Headers $authorization 
        return $grpInfo.descriptor
        
        # return "Microsoft.VisualStudio.Services.Identity;" +  $grpInfo.domain + "\" + "[" + $groupName + "]"
        # for later use
        #descriptor = "Microsoft.IdentityModel.Claims.ClaimsIdentity;" +  $domain + "\" + $userParams.userEmail
        #descriptor = "Microsoft.VisualStudio.Services.Identity;" + $grp.descriptor
    }
}
