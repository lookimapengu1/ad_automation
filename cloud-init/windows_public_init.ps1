#ps1
$pwd = ConvertTo-SecureString -String <YOUR WINDOWS PASSWORD HERE> -AsPlainText -Force
Set-LocalUser Administrator -Password $pwd
Enable-LocalUser Administrator
