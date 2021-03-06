$chocolateyInstallScriptWebAddress = "https://chocolatey.org/install.ps1"

#Appends path if not already present
$systemPathString = [string]$env:Path.ToLower()
$chocolateyPathString = [string]";${env:SystemDrive}\chocolatey\bin"
if($systemPathString.Contains($chocolateyPathString.ToLower()) -eq $false)
{
	$env:Path = $env:Path + $chocolateyPathString
	echo "Chocolatey was added to PATH"
}
else
{
	echo "Chocolatey path already present in PATH"
}

#Downloads the install script
$webclient = New-Object -TypeName System.Net.WebClient
$chocolateyInstallScriptContent = $webclient.DownloadString($chocolateyInstallScriptWebAddress)

#Runs the install script
iex $chocolateyInstallScriptContent