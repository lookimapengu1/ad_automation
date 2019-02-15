#ps1
$pwd = ConvertTo-SecureString -String 'Oracle:1234567' -AsPlainText -Force
Set-LocalUser Administrator -Password $pwd
Enable-LocalUser Administrator
