Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1'
Import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5)+ '\ConfigurationManager.psd1')

$mypath = $MyInvocation.MyCommand.Path
$mypath = Split-Path $mypath -Parent

###
### Change Root Folder Name ###
###

$collection_folder_name = "FOLDER MAKER"
$application_folder_name = "deneme_app"
$package_folder_name = "deneme_pkg"




#Get SiteCode
$SiteCode = Get-PSDrive -PSProvider CMSITE
Set-location $SiteCode":"

function Make-CollectionFolders {
    
    new-item -Name $collection_folder_name -Path $($SiteCode.Name+":\DeviceCollection\")
    
    $collection_csv = Import-Csv -path $mypath\collection.csv
    
    foreach($line in $collection_csv) {

        Write-Output "Creating Folders"

        if([string]::IsNullOrEmpty($line.1)) {

            if([string]::IsNullOrEmpty($line.2)) { 
            
                new-item -Name $line.3 -Path $($SiteCode.Name+":\DeviceCollection\" + $collection_folder_name + "\" + $x.1 + "\" + $y.2)
                
            } else {
                $y = $line
                new-item -Name $line.2 -Path $($SiteCode.Name+":\DeviceCollection\" + $collection_folder_name + "\" + $x.1)
                
            }       
        
        } else {
            $x = $line
            new-item -Name $line.1 -Path $($SiteCode.Name+":\DeviceCollection\" + $collection_folder_name)
            
        }
    }
}


function Make-ApplicationFolders {

    new-item -Name $application_folder_name -Path $($SiteCode.Name+":\Application\")
    

    $application_csv = Import-Csv -path $mypath\application.csv

    foreach($line in $application_csv) {
        
        Write-Output "Creating Folders"

        if([string]::IsNullOrEmpty($line.1)) {

            if([string]::IsNullOrEmpty($line.2)) { 
            
                new-item -Name $line.3 -Path $($SiteCode.Name+":\Application\" + $application_folder_name + "\" + $x.1 + "\" + $y.2)
                
            } else {
                $y = $line
                new-item -Name $line.2 -Path $($SiteCode.Name+":\Application\" + $application_folder_name + "\" + $x.1)
                
            }       
        
        } else {
            $x = $line
            new-item -Name $line.1 -Path $($SiteCode.Name+":\Application\" + $application_folder_name)
           
        }

        
    }
}

function Make-PackageFolders {

    new-item -Name $package_folder_name -Path $($SiteCode.Name+":\Package\")
    

    $package_csv = Import-Csv -path $mypath\package.csv

    foreach($line in $package_csv) {

        Write-Output "Creating Folders"

        if([string]::IsNullOrEmpty($line.1)) {

            if([string]::IsNullOrEmpty($line.2)) { 
            
                new-item -Name $line.3 -Path $($SiteCode.Name+":\Package\" + $package_folder_name + "\" + $x.1 + "\" + $y.2)
                
            } else {
                $y = $line
                new-item -Name $line.2 -Path $($SiteCode.Name+":\Package\" + $package_folder_name + "\" + $x.1)                
            }       
        
        } else {
            $x = $line
            new-item -Name $line.1 -Path $($SiteCode.Name+":\Package\" + $package_folder_name)           
        }       
    }
}


Write-Host " "

Write-Host "SCCM Folder Maker - Made by Yasin Seven"

Write-Host " "
Write-Host "1) Create Collection Folders"
Write-Host "2) Create Application Folders"
Write-Host "3) Create Package Folders"
Write-Host " "


#Getting Menu Input from User
$input = Read-Host -Prompt "Select the action."

if ($input -eq 1) {
    Make-CollectionFolders
}
elseif ($input -eq 2){
    Make-ApplicationFolders    
}
elseif ($input -eq 3){
    Make-PackageFolders    
}



