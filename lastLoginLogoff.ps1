# Define the event ID for logoff
$logoffEventID = 4634

# Get the last logoff event
$logoffEvent = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=$logoffEventID} -MaxEvents 1

# Display the logoff time
if ($logoffEvent) {
    $logoffTime = $logoffEvent.TimeCreated
    Write-Output "Last logoff time: $logoffTime"
} else {
    Write-Output "No logoff events found."
}

# Define the event ID for logon
$logonEventID = 4624

# Get the last logon event
$logonEvent = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=$logonEventID} -MaxEvents 1

# Display the logon time
if ($logonEvent) {
    $logonTime = $logonEvent.TimeCreated
    Write-Output "Last logon time: $logonTime"
} else {
    Write-Output "No logon events found."
}
