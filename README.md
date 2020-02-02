# UDWordTree
google chart wordtree for universaldashboard based on https://github.com/rakannimer/react-google-charts

## Parameters

  There are only four parameters when it comes to this component, and only one of them is mandatory which is the data parameter,
  as without this parameter there would be nothing to display
The **-data** parameter needs to be passed as separate arrays, you may wish to design a helper function to prepare this data.
The **-word** parameter focuses on a particular word in the list of arrays you have passed it.  This does effect the display
of the wordtree chart
The **-width** and **-height** parameters are strings and accept values like 400px or 100%


## Demo

```
Import-Module -Name universaldashboard.Community -RequiredVersion 2.8.1
Import-Module 'universaldashboard.UDWordTree'
Get-UDDashboard | Stop-UDDashboard
$theme = New-UDTheme -Name 'Basic' -Definition @{
    'main' = @{
        'padding-left'   = '5px'
        'padding-right'  = '5px'
        'padding-top'    = '5px'
        'padding-bottom' = '5px'
    }
} -Parent 'Default'
Start-UDDashboard -Port 1000 -AutoReload -Dashboard (
    New-UDDashboard -Title 'Powershell UniversalDashboard' -Theme $theme -Content {
        New-UDRow -Columns {
            New-UDColumn -Size 12 -Content {
                New-UDWordTree -Id "WORDTREE"-width "100%" -height "400px" -data {
                    $b = @( @("Phrases"),
                        @("UniversalDashboard is Powershell most popular web framework"),
                        @("Powershell UniversalDashboard works on all platforms"),
                        @("Powershell UniversalDashboard is awesome"),
                        @("Powershell UniversalDashboard is versatile"),
                        @("Powershell UniversalDashboard is perfect"),
                        @("Powershell UniversalDashboard is great value"),
                        @("Powershell UniversalDashboard is easy to use"),
                        @("Powershell UniversalDashboard great for displaying data"),
                        @("Powershell UniversalDashboard great for creating bespoke applications"),
                        @("Powershell UniversalDashboard great for presentations"),
                        @("Powershell UniversalDashboard has many charts"),
                        @("Powershell UniversalDashboard has many components"),
                        @("Powershell UniversalDashboard has a forum"),
                        @("Powershell UniversalDashboard has a marketplace")
                    )
                    $b
                } -word "UniversalDashboard"
            }

        }
    }
)
```

  You could re-run this without the **-word** parameter to see the difference.  The amount of times the word occurs is 
  automatically calculated and the more frequent the word is, the bigger the font appears.
