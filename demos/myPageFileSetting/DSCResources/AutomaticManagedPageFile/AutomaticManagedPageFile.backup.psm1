function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $Enabled
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    <#
    $returnValue = @{
    Enabled = [System.Boolean]
    }

    $returnValue
    #>

    $cs = Get-CimInstance win32_computersystem 
    Return @{
        Enabled = $cs.AutomaticManagedPageFile
    }
    
} #get

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $Enabled
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1

    $cs = Get-CimInstance win32_computersystem 

    if ($Enabled) {
        $property = @{AutomaticManagedPageFile = $True}
    }
    else {
        $property = @{AutomaticManagedPageFile = $False}
    }
       
    #commit the changes
    $cs | Set-CimInstance -Property $property 
   

} #Set

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $Enabled
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $result = [System.Boolean]
    
    $result
    #>
    $cs = Get-CimInstance win32_computersystem 
    if ($Enabled -eq $CS.AutomaticManagedPagefile) {
        Return $True
    }
    else {
        Return $False
    }
} #Test


Export-ModuleMember -Function *-TargetResource

