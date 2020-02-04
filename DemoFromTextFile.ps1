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