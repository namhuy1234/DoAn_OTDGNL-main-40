# Kiem tra cong 8000 va 5500 truoc khi chay he thong.
# Chi tat may chu cu cua du an; neu cong bi chuong trinh khac chiem thi bao de nguoi dung tu dong.
# Khong dua vao netstat vi tren mot so ban Windows lenh nay co luc bao PID bang 0.

function CongTrong($cong) {
    foreach ($diaChi in [Net.IPAddress]::Loopback, [Net.IPAddress]::Any) {
        $nghe = New-Object Net.Sockets.TcpListener($diaChi, $cong)
        try { $nghe.Start(); $nghe.Stop() } catch { return $false }
    }
    return $true
}

$mayChu = @{
    8000 = 'uvicorn.*--port 8000'
    5500 = 'http-server.*-p 5500|http\.server 5500'
}

$biChan = $false
foreach ($cong in 8000, 5500) {
    if (CongTrong $cong) { continue }
    $cu = Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^(python|node)' -and $_.CommandLine -match $mayChu[$cong] }
    foreach ($tt in $cu) {
        Write-Host "Cong ${cong}: dang tat may chu cu (PID $($tt.ProcessId))..."
        taskkill /PID $tt.ProcessId /T /F 2>$null | Out-Null
    }
    Start-Sleep -Seconds 2
    if (-not (CongTrong $cong)) {
        Write-Host "Cong $cong dang bi mot chuong trinh khac chiem. Hay dong chuong trinh do roi chay lai."
        $biChan = $true
    }
}
if ($biChan) { exit 1 }
exit 0
