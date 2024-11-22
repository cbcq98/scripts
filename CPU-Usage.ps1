# Define thresholds
$cpuThreshold = 80
$memoryThreshold = 80

# Get resource utilization
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue
$memoryUsage = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / (Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize * 100

# Alert condition
if ($cpuUsage -gt $cpuThreshold -or $memoryUsage -lt $memoryThreshold) {
    $body = "Alert: Resource utilization exceeded thresholds.`nCPU: $cpuUsage%`nMemory: $memoryUsage% free."
    Send-MailMessage -To "admin@domain.com" -From "server@domain.com" -Subject "Resource Alert" -Body $body -SmtpServer "smtp.domain.com"
}
