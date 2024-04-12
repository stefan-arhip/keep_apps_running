$Interval = 60

while ($True) {
    Get-Content '.\filelist.txt' | ForEach-Object {
        $var = $_.Split('=')

        New-Variable -Name AppName -Value $var[0]
        New-Variable -Name AppPath -Value $var[1]
        New-Variable -Name AppParam -Value $var[2]

    
        $AppIsRunning = 0
	    $CurrentTime = Get-Date -Format "yyyymmdd-HHmmss"
        (Get-Process).ProcessName | ForEach-Object {
            if ($_ -imatch $AppName) {
                $AppIsRunning++            
                Write-Host $currentTime '-'$_ 'is running'
            }
        }
        
        if ($AppIsRunning -eq 0){
            Write-Host $CurrentTime '- launch'$AppName
            if ($AppParam -eq "") {
                Start-Process -FilePath $AppPath
            } 
            else {
                Start-Process -FilePath $AppPath $AppParam
            }
        }

        Remove-Variable -Name AppName
        Remove-Variable -Name AppPath
        Remove-Variable -Name AppParam 

        } 
    Start-Sleep -Seconds $Interval
}