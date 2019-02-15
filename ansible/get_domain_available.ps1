param (
[Parameter(
Mandatory = $true)]
[string]$domainName
)
$result = @{};
 
echo $domainName

try {
$Error.Clear();
 
$nltestresults = ((nltest /dsgetdc:$domainName) -replace ":", "=" | `
Where-Object {$_ -match "="}) -join "`r`n" | `
ConvertFrom-StringData
 
new-object -TypeName PSCustomObject -Property $nltestresults | out-null
 
if (($nltestresults.Count -eq 0)) {
Fail-Json -obj @{} -message "Domain is Unavailable ... "
}
else {
$domName = $nltestresults.'Dom Name'
Set-DnsServerPrimaryZone -Name $domainName -DynamicUpdate "NonsecureAndSecure" | Out-Null
$result.data = "$domName is available"
}
Exit-Json -obj $result
}
catch {
Fail-Json -obj $result -message "Exception.Message=$($_.Exception.Message); ScriptStackTrace=$($_.ScriptStackTrace); Exception.StackTrace=$($_.Exception.StackTrace); FullyQualifiedErrorId=$($_.FullyQualifiedErrorId); Exception.InnerException=$($_.Exception.InnerException)"
}