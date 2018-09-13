# Prompt for Choice

## Introduction

Prompts the user to select from a list of choices. It is a simple wrapper around the .NET function [$Host.UI.PromptForChoice](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.host.pshostuserinterface.promptforchoice) to simplify it's usage.
There is a nice [Windows PowerShell Tip of the Week](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ff730939(v=technet.10)) article that explains the usage of the .NET function.

If you want to make your life easier, use this module.

## Examples

The module makes the usage really handy.

````
Get-Choice -Message "Do you really want this?" -YesNo

Do you really want this?
[Y] Yes [N] No [?] Help (default is "Yes"):
````

The shortest way to get a choice from the user.

````
Choice "Do you really want this?"

Do you really want this?
[Y] Yes [N] No [?] Help (default is "Yes"):
````

While the interface is optimized for simplicity, you still have all the power to define custom choices and help messages.

````
Choice "Do you really want this?" -Choices "&Yes", "&No", @{ Choice="&Dice"; Help="Can't decide? Go for a 50/50 Chance" }

Do you really want this?
[Y] Yes [N] No [D] Dice [?] Help (default is "Yes"): ?
Y -
N -
D - Can't decide? Go for a 50/50 Chance
[Y] Yes [N] No [] Dice [?] Help (default is "Yes"):
````