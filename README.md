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
                    $words = @( @("Phrases"),
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
                    $words
                } -word "UniversalDashboard"
            }

        }
    }
)
```

  You could re-run this without the **-word** parameter to see the difference.  The amount of times the word occurs is 
  automatically calculated and the more frequent the word is, the bigger the font appears.
  
  ## Improved Demo from text file with search capabilities
  
  The ud.txt file used in this example is availble on this repository, massive thanks to Augustin Ziegler for providing the solution for reading the data from a text file....I am sure this would also work from a variable, but I was using a .txt for my purposes. This is the exact script that is being used for the .GIF icon and which is also located on this repository 
  
  ```
  Import-Module -Name universaldashboard.community -RequiredVersion 2.8.1
Import-Module -Name UniversalDashboard.UDWordTree
Get-UDDashboard | Stop-UDDashboard
$theme = New-UDTheme -Name 'Basic' -Definition @{
    'main' = @{
        'padding-left'   = '5px'
        'padding-right'  = '5px'
        'padding-top'    = '5px'
        'padding-bottom' = '5px'
    }
} -Parent 'Default'
$Initialization = New-UDEndpointInitialization -Module @('UniversalDashboard.UDWordTree')
Start-UDDashboard -Port 1000 -AutoReload -Dashboard (
    New-UDDashboard -Title 'Powershell UniversalDashboard' -Theme $theme -Content {
        New-UDRow -Columns {
            New-UDColumn -Id "col1" -Size 12 -Endpoint {
                #read file content
                $Data = Get-Content "C:\UD\ud.txt"
                #init list variable
                [System.Collections.ArrayList]$UDWordTreeData = @()
                #foreach file content and add to list
                $Data | % {
                    $UDWordTreeData.Add(@([string]$_)) | Out-Null
                }
                New-UDWordTree -Id "WORDTREE"-width "100%" -height "250px" -data { $UDWordTreeData } -word $Session:filter
                New-UDInput -Title "Search WordTree" -Endpoint {
                    param($search)

                    New-UDInputAction -Toast "Searching for $search" -Duration 3000
                    $Session:filter = $search
                    Sync-UDElement -Id "col1"
                }
            }

        }

    } -EndpointInitialization $Initialization
)
  ```
