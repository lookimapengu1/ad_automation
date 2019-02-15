#ps1
$pwd = ConvertTo-SecureString -String <YOUR WINDOWS PASSWORD> -AsPlainText -Force
Set-LocalUser Administrator -Password $pwd
Enable-LocalUser Administrator

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file