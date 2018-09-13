<#
.SYNOPSIS
    Prompts the user to select from a list of choices. 
.DESCRIPTION
    A simple wrapper around the .NET function $Host.UI.PromptForChoice to simplify it's usage. 
.EXAMPLE
    PS C:\> Get-Choice -Message "Do you really want this?" -YesNo

    Do you really want this?
    [Y] Yes [N] No [?] Help (default is "Yes"):
.EXAMPLE
    PS C:\> Choice "Do you really want this?"

    Do you really want this?
    [Y] Yes [N] No [?] Help (default is "Yes"):
.EXAMPLE
    PS C:\> Choice "Do you really want this?" -Choices "&Yes", "&No", @{ Choice="&Dice"; Help="Can't decide? Go for a 50/50 Chance" }

    Do you really want this?
    [Y] Yes [N] No [D] Dice [?] Help (default is "Yes"): ?
    Y -
    N -
    D - Can't decide? Go for a 50/50 Chance
    [Y] Yes [N] No [] Dice [?] Help (default is "Yes"):
#>
function Get-Choice {
    [Alias("Choice")]
    [CmdletBinding(DefaultParameterSetName="YesNo")]
    param (
        [Parameter()]
        [string] $Title,

        [Parameter(Mandatory=$true, Position=0)]
        [string] $Message, 

        [Parameter(Position=1, ParameterSetName="Choices")]
        $Choices, 

        [Parameter(ParameterSetName="YesNo")]
        [switch] $YesNo,

        [Parameter(ParameterSetName="YesNoCancle")]
        [switch] $YesNoCancle, 

        [Parameter()]
        [int] $Default
    )

    switch ($PSCmdlet.ParameterSetName) {
        "YesNo" { $Choices = "&Yes", "&No" }
        "YesNoCancle" { $Choices = "&Yes", "&No", "&Cancle" }
        Default { }
    }

    $descriptions = [System.Management.Automation.Host.ChoiceDescription[]]($Choices | ForEach-Object {
        if($_ -is [string]) {
            New-Object System.Management.Automation.Host.ChoiceDescription $_
        } else {
            New-Object System.Management.Automation.Host.ChoiceDescription $_.Choice, $_.Help
        }
    })

    return $Host.UI.PromptForChoice($Title, $Message, $descriptions, $Default)
}