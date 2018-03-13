 <#
    .SYNOPSIS 
    Shows entry from /etc/passwd 

    .DESCRIPTION
    Get-User shows all the user in /etc/passwd 

   .EXAMPLE
    C:\PS> Import-Module ./Get-User.ps1

   .EXAMPLE
    C:\PS> Get-User   

   .EXAMPLE
    C:\PS> Get-User -Username <username>
#>

function Get-User ($Username = $null) 
{
    $csvlist = cat /etc/passwd | ConvertFrom-CSV -Delimiter ':' -Header Name,Passwd,UID,GID,Description,Home,Shell
    if ($Username -ne $null) {
        $csvlist | Where-Object {$_.Name -eq $Username}
    }
    else {
        $csvlist | Sort-Object Name |
        Format-Table
    }
}
