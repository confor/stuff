# script to install scoop non-globally in a custom directory

# check powershell version >= 5.0
# > Make sure you have PowerShell 5.0 or later installed. If you're on Windows 10 or Windows Server 2012
# > you should be all set, but Windows 7 and Windows Server 2008 might have older versions.
if (-Not ($PSVersionTable.PSVersion.Major -ge 5)) {
	write "Scoop requires powershell 5.0 or greater"
	write "Get that shit sorted out"
	pause
	exit 1
}

# change installation directory
# yes i have P: drives in my desktop
$env:SCOOP='P:\scoop'
[environment]::setEnvironmentVariable('SCOOP',$env:SCOOP,'User')

write "Will change ExecutionPolicy, current is:"
Get-ExecutionPolicy

$reply = Read-Host -Prompt "Continue? [y/n]"
if ( $reply -eq "y" ) {
	#Set-ExecutionPolicy remotesigned -scope currentuser
	
	# download and install the thing
	Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
	pause
} else {
	write "Aborting"
}
